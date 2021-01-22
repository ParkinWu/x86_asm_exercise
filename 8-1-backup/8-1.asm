    app_lba_start equ 100

SECTION mbr align=16 vstart=0x7c00
    mov ax, 0
    mov ss, ax
    mov sp, ax

    mov ax, [cs:phy_base]
    mov dx, [cs:phy_base+0x02]
    mov bx, 16
    div bx
    mov ds, ax
    mov es, ax

    phy_base dd 0x10000

times 510-($-$$) db 0
                 db 0x55, 0xaa
