## 编译4-2.asm 写入磁盘

### 如何编译
```
nasm -f bin 4-2.asm -o 4-2
```


### 如何安装VirtualBox manjaro

```
$ mhwd-kernel -li
Currently running: 5.4.0-1-MANJARO (linux54)
The following kernels are installed in your system:
   * linux54
```

```
sudo pacman -Syu virtualbox linux54-virtualbox-host-modules
```

```
sudo vboxreload
```

### 如何创建虚拟机

创建VHD格式虚拟磁盘


### 如何写入VirtualBox 磁盘

```
sudo dd if=4-2 of=../../VHD/LEARN-ASM.vhd seek=0 bs=512 count=1 conv=notrunc
```


写入虚拟机，启动观察VirtualBox显示
