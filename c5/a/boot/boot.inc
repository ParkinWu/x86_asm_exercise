LOADER_BASE_ADDR equ 0x900
LOADER_START_SECTOR equ 0x2

; gdt 描述符

DESC_G_4K       equ     (1 << 23)
DESC_D_32       equ     (1 << 22)
DESC_L          equ     (0 << 21)
DESC_AVL        equ     (0 << 20)

DESC_LIMIT_CODE2 equ    (0xf << 16)
DESC_LIMIT_DATA2 equ    DESC_LIMIT_CODE2
DESC_LIMIT_VIDEO equ    (0x0 << 16)

DESC_P           equ    (1 << 15)
DESC_DPL_0       equ    (0 << 15)
DESC_DPL_1       equ    (1 << 15)
DESC_DPL_2       equ    (2 << 15)
DESC_DPL_3       equ    (3 << 15)


DESC_S_CODE      equ    (1 << 12)
DESC_S_DATA      equ    DESC_S_CODE
DESC_S_sys      equ    (0 << 12)

DESC_TYPE_CODE   equ    (8 << 8)
DESC_TYPE_DATA   equ    (2 << 8)

DESC_CODE_HIGH4  equ    (0x00 << 24) + DESC_G_4K + DESC_D_32 + DESC_L + DESC_AVL + DESC_LIMIT_CODE2 + DESC_P + DESC_DPL_0 + DESC_S_CODE + DESC_TYPE_CODE + 0x00
DESC_DATA_HIGH4  equ    (0x00 << 24) + DESC_G_4K + DESC_D_32 + DESC_L + DESC_AVL + DESC_LIMIT_DATA2 + DESC_P + DESC_DPL_0 + DESC_S_DATA + DESC_TYPE_DATA + 0x00
DESC_VIDEO_HIGH4  equ    (0x00 << 24) + DESC_G_4K + DESC_D_32 + DESC_L + DESC_AVL + DESC_LIMIT_VIDEO + DESC_P + DESC_DPL_0 + DESC_S_DATA + DESC_TYPE_DATA + 0x0B

RPL0    equ     0
RPL1    equ     1
RPL2    equ     2
RPL3    equ     3

TI_GDT  equ     000b
TI_LDT  equ     100b


; 第5章新增

PAGE_DIR_TABLE_POS equ 0x100000 ;; 高1MB位置

PG_P equ 1b
PG_RW_R equ 00b
PG_RW_W equ 10b
PG_US_S equ 000b
PG_US_U equ 100b
