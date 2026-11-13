ENTRY(_start)
SECTIONS {
    . = 1M;
    .text : { *(.multiboot) *(EXCLUDE_FILE(*uprog.o) .text) }
    .rodata : { *(EXCLUDE_FILE(*uprog.o) .rodata*) }
    .data : { *(EXCLUDE_FILE(*uprog.o) .data*) }
    . = ALIGN(4096);
    user_start = .;
    .user : { *uprog.o(.text*) *uprog.o(.rodata*) *uprog.o(.data*) *uprog.o(.bss*) *uprog.o(COMMON) }
    . = ALIGN(4096);
    user_end = .;
    .bss : { *(.bss*) *(COMMON) kernel_end = .; }
}
