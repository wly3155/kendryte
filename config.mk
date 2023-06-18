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

C_FLAGS += \
	-mcmodel=medany \
	-march=rv64imafdc \
	-fno-common \
	-ffunction-sections \
	-fdata-sections \
	-fstrict-volatile-bitfields \
	-fno-zero-initialized-in-bss \
	-O2 \
	-ggdb \
	-std=gnu11 \
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
	-Wno-error=missing-braces \
	-Wno-old-style-declaration

C_FLAGS += \
	-DCONFIG_LOG_COLORS \
	-DCONFIG_LOG_ENABLE \
	-DCONFIG_LOG_LEVEL=LOG_INFO \
	-D__riscv64

CXX_FLAGS += \
	-mcmodel=medany \
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

LD_FLAGS += \
	-nostartfiles \
	-static \
	-Wl,--gc-sections \
	-Wl,-static \
	-Wl,--start-group \
	-Wl,--whole-archive \
	-Wl,--no-whole-archive \
	-Wl,--end-group \
	-Wl,-EL \
	-Wl,--start-group \
	-lm \
	-latomic \
	-lc \
	-lstdc++ \
	-Wl,--end-group \
	-lm \
	-lstdc++ \
	-lm

include platform.mk
