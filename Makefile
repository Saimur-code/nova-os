.RECIPEPREFIX = >
CC = clang --target=i386-none-elf
CFLAGS = -ffreestanding -fno-stack-protector -fno-pic -fno-pie -mno-sse -mno-mmx -O2 -fno-strict-aliasing -Wall

all: kernel.elf

boot.o: boot.s
> $(CC) -c boot.s -o boot.o

kernel.o: kernel.c disk.c usermode.c
> $(CC) $(CFLAGS) -c kernel.c -o kernel.o

uprog.o: uprog.c
> $(CC) $(CFLAGS) -c uprog.c -o uprog.o

kernel.elf: boot.o kernel.o uprog.o linker.ld
> ld.lld -m elf_i386 -T linker.ld boot.o kernel.o uprog.o -o kernel.elf

run: kernel.elf
> qemu-system-x86_64 -kernel kernel.elf -drive file=disk.img,format=raw -serial stdio -display none

clean:
> rm -f boot.o kernel.o uprog.o kernel.elf
