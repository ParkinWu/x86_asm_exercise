%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR
LOADER_STACK_TOP    equ     LOADER_BASE_ADDR


jmp loader_start

GDT_BASE: dd 0x0000000
          dd 0x0000000

CODE_DESC: dd 0x0000FFFF
           dd DESC_CODE_HIGH4

DATA_STACK_DESC: dd 0x0000FFFF
                 dd DESC_DATA_HIGH4

VIDEO_DESC: dd 0x80000007
            dd DESC_VIDEO_HIGH4

GDT_SIZE equ $ - GDT_BASE
GDT_LIMIT equ GDT_SIZE - 1

times 60 dq 0

SELECTOR_CODE equ  (0x0001 << 3) + TI_GDT + RPL0
SELECTOR_DATA equ  (0x0002 << 3) + TI_GDT + RPL0
SELECTOR_VIDEO equ  (0x0003 << 3) + TI_GDT + RPL0

gdt_ptr dw GDT_LIMIT
        dd GDT_BASE

loader_message db '2 loader in real.'

loader_start:
    mov sp, LOADER_BASE_ADDR
    mov bp, loader_message
    mov cx, 17
    mov ax, 0x1301
    mov bx, 0x001f
    mov dx, 0x1800
    int 0x10

    in al, 0x92
    or al, 0x02
    out 0x92, al

    lgdt [gdt_ptr]

    mov eax, cr0
    or eax, 0x0001
    mov cr0, eax

    jmp dword SELECTOR_CODE:p_mode_start

[bits 32]
p_mode_start:
    mov ax, SELECTOR_DATA
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, LOADER_STACK_TOP
    mov ax, SELECTOR_VIDEO
    mov gs, ax

    mov byte [gs:160], 'P'


    jmp $

setup_page:
    mov ecx, 4096
    mov esi, 0
    
.clear_page_dir:
    mov byte [PAGE_DIR_TABLE_POS + esi], 0
    inc esi
    loop .clear_page_dir
    
.create_pde:
    mov eax, PAGE_DIR_TABLE_POS
    add eax, 0x1000 ; 目录 总占据4K大小，此处是第一个页表的位置
    mov ebx, eax

    or eax, PG_US_U | PG_RW_W | PG_P
    mov [PAGE_DIR_TABLE_POS + 0x0], eax ; 页目录的第一项指向页表的第一项

    mov [PAGE_DIR_TABLE_POS + 0xc00], eax ; 第768个页目录，也指向页表的第一项，768内核3-4G 空间的第一个页目录
    sub eax, 0x1000

    mov [PAGE_DIR_TABLE_POS + 4096], eax ;最后一个页目录指向自己的物理地址

    mov ecx, 256
    mov esi, 0
    mov edx, PG_US_U | PG_RW_W | PG_P

.create_pte:
    mov [ebx+esi * 4], edx ; 第一个页表映射到物理地址 0
    add edx, 4096
    inc esi
    loop .create_pte

; 创建内核其他PDE
    mov eax, PAGE_DIR_TABLE_POS
    add eax, 0x2000
    or eax, PG_US_U | PG_RW_W | PG_P
    mov ebx, PAGE_DIR_TABLE_POS
    mov ecx, 254
    mov esi, 769

.create_kernel_pde:
    mov [ebx+esi*4], eax
    inc esi
    add eax, 0x1000
    loop .create_kernel_pde
    ret
