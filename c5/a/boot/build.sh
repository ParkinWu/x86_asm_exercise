#!/bin/bash


rm -rf *.bin

nasm -f bin -o mbr.bin mbr.S

nasm -f bin -o loader.bin loader.S

gcc -c -m32 -o main.o main.c

ld -melf_i386 main.o -Ttext 0xc0001500  -e main -o kernel.bin

dd if=mbr.bin of=../../../hd60M.img bs=512 count=1 conv=notrunc

dd if=loader.bin of=../../../hd60M.img bs=512 seek=2 count=200 conv=notrunc

dd if=kernel.bin of=../../../hd60M.img bs=512 count=200 seek=9 conv=notrunc
