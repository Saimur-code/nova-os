NOVA
====
Nova is a hobby operating system written from scratch: its own
32-bit x86 kernel, its own file system, and its own user mode.
It is not based on Linux or any other existing kernel.

Built in Bangladesh by Saimur, entirely on an Android tablet using
Termux, and tested in the QEMU emulator.

Current version: Nova v0.7 (user mode)

FEATURES
--------
- Boots through Multiboot (loaded by QEMU with -kernel)
- Memory management (mem, alloc, free)
- Multitasking: spawn tasks, list them (ps), kill them
- NovaFS: a simple file system on an ATA disk
  (ls, cat, write, append, rm, df, disk, sector, format)
- User mode (ring 3) with system calls. User programs run
  separated from the kernel (run, ush, hello, count)
- Memory protection: a bad program that writes into kernel memory
  gets a page fault, Nova stops it and keeps running
  (evil1, evil2, evil3 are tests for this)
- Text-mode windowed UI with System and Tasks panels

PROJECT FILES
-------------
boot.s      Multiboot header and entry point (GNU assembler)
kernel.c    The kernel (includes disk.c and usermode.c)
disk.c      ATA disk driver and NovaFS file system
usermode.c  Ring 3 switch, system calls, user program loader
uprog.c     Built-in user programs
linker.ld   Linker script (puts user programs in their own region)
Makefile    Build and run

BUILD AND RUN
-------------
See quick_start.txt

NOTES
-----
The Makefile builds with -fno-strict-aliasing. The disk driver reads
sectors through a 16-bit pointer into buffers that are also read as
32-bit values, and without this flag optimized builds can misread
the disk.
