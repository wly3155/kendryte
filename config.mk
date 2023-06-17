_CROSS_COMPILER_DIR_=/opt/kendryte-toolchain/bin/riscv64-unknown-elf-
_CROSS_COMPILER_GCC_=$(_CROSS_COMPILER_DIR_)gcc
_CROSS_COMPILER_G++_=$(_CROSS_COMPILER_DIR_)g++
_CROSS_COMPILER_LD_=$(_CROSS_COMPILER_DIR_)ld
_CROSS_COMPILER_OBJDUMP_=$(_CROSS_COMPILER_DIR_)objdump
_CROSS_COMPILER_OBJCOPY_=$(_CROSS_COMPILER_DIR_)objcopy
_CROSS_COMPILER_AR_=$(_CROSS_COMPILER_DIR_)ar
_CROSS_COMPILER_GDB_=$(_CROSS_COMPILER_DIR_)gdb
_CROSS_COMPILER_SIZE_=$(_CROSS_COMPILER_DIR_)size

C_FLAGS +=  \
	-fno-common \
	-ffunction-sections \
	-fdata-sections \
	-fstrict-volatile-bitfields \
	-fno-zero-initialized-in-bss \
	-ffast-math \
	-fno-math-errno \
	-fsingle-precision-constant \
	-O -ggdb -std=gnu11 -Wno-pointer-to-int-cast \
	-Wall -Werror=all -Wno-error=unused-function \
	-Wno-error=unused-but-set-variable \
	-Wno-error=unused-variable -Wno-error=deprecated-declarations \
	-Wextra -Werror=frame-larger-than=32768 \
	-Wno-unused-parameter -Wno-sign-compare \
	-Wno-error=missing-braces -Wno-error=return-type \
	-Wno-error=pointer-sign -Wno-missing-braces \
	-Wno-strict-aliasing -Wno-implicit-fallthrough \
	-Wno-missing-field-initializers -Wno-int-to-pointer-cast \
	-Wno-error=comment -Wno-error=logical-not-parentheses \
	-Wno-error=duplicate-decl-specifier -Wno-error=parentheses \
	-Wno-old-style-declaration -g \
	-nostartfiles \
	-static -Wl,--gc-sections \
        -Wl,-static \
        -Wl,--start-group \
        -Wl,--whole-archive \
        -Wl,--no-whole-archive \
        -Wl,--end-group \
        -Wl,-EL \
        -Wl,--no-relax

include platform.mk
