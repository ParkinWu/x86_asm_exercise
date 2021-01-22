%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR

mov byte [gs:0x00], '2'
mov byte [gs:0x01], 0xA4
mov byte [gs:0x02], ' '
mov byte [gs:0x03], 0xA4
mov byte [gs:0x04], 'M'
mov byte [gs:0x05], 0xA4
mov byte [gs:0x06], 'B'
mov byte [gs:0x07], 0xA4
mov byte [gs:0x08], 'R'
mov byte [gs:0x09], 0xA4

jmp $
