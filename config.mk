_CROSS_COMPILER_DIR_=/opt/kendryte-toolchain
_CROSS_COMPILER_BIN_DIR_=$(_CROSS_COMPILER_DIR_)/bin

_CROSS_COMPILER_PREFIX=$(_CROSS_COMPILER_BIN_DIR_)/riscv64-unknown-elf-
_CROSS_COMPILER_GCC_=$(_CROSS_COMPILER_PREFIX)gcc
_CROSS_COMPILER_G++_=$(_CROSS_COMPILER_PREFIX)g++
_CROSS_COMPILER_LD_=$(_CROSS_COMPILER_PREFIX)ld
_CROSS_COMPILER_OBJDUMP_=$(_CROSS_COMPILER_PREFIX)objdump
_CROSS_COMPILER_OBJCOPY_=$(_CROSS_COMPILER_PREFIX)objcopy
_CROSS_COMPILER_AR_=$(_CROSS_COMPILER_PREFIX)ar
_CROSS_COMPILER_GDB_=$(_CROSS_COMPILER_PREFIX)gdb
_CROSS_COMPILER_SIZE_=$(_CROSS_COMPILER_PREFIX)size

ifeq ($(CFG_RISCV_BUILT_IN),yes)
INCLUDES += -I$(_CROSS_COMPILER_DIR_)/riscv64-unknown-elf/include
INCLUDES += -I$(_CROSS_COMPILER_DIR_)/riscv64-unknown-elf/include/c++/8.2.0
INCLUDES += -I$(_CROSS_COMPILER_DIR_)/riscv64-unknown-elf/include/c++/8.2.0/backward
INCLUDES += -I$(_CROSS_COMPILER_DIR_)/riscv64-unknown-elf/include/c++/8.2.0/riscv64-unknown-elf

INCLUDES += -I$(_CROSS_COMPILER_DIR_)/lib/gcc/riscv64-unknown-elf/8.2.0/include
INCLUDES += -I$(_CROSS_COMPILER_DIR_)/lib/gcc/riscv64-unknown-elf/8.2.0/include-fixed
endif

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

CXX_FLAGS += -mcmodel=medany \
		-march=rv64imafdc \
        -fno-common \
        -ffunction-sections \
        -fdata-sections \
        -fstrict-volatile-bitfields \
        -fno-zero-initialized-in-bss \
        -O2 \
        -ggdb \
		-std=gnu++17 \
		-Wall \
		-Werror=all \
		-Wno-error=unused-function \
		-Wno-error=unused-but-set-variable \
		-Wno-error=unused-variable \
		-Wno-error=deprecated-declarations \
		-Wno-error=maybe-uninitialized \
		-Wextra \
		-Werror=frame-larger-than=65536 \
		-Wno-unused-parameter \
		-Wno-unused-function \
		-Wno-implicit-fallthrough \
		-Wno-sign-compare \
		-Wno-error=missing-braces

LD_FLAGS += -Wl,--start-group \
        -Wl,--end-group

include platform.mk
