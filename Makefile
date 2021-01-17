
TARGET = hello_world
GCC = /opt/kendryte-toolchain/bin/riscv64-unknown-elf-gcc
AR = /opt/kendryte-toolchain/bin/riscv64-unknown-elf-ar
OUT := out

C_FLAGS :=  \
	-mcmodel=medany \
	-mabi=lp64f \
	-march=rv64imafc \
	-fno-common \
	-ffunction-sections \
	-fdata-sections \
	-fstrict-volatile-bitfields \
	-fno-zero-initialized-in-bss \
	-ffast-math \
	-fno-math-errno \
	-fsingle-precision-constant \
	-Os -ggdb -std=gnu11 -Wno-pointer-to-int-cast \
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
	-Wno-old-style-declaration -g 

C_DEFINES := -DCONFIG_LOG_COLORS \
	-DCONFIG_LOG_ENABLE -DCONFIG_LOG_LEVEL=LOG_VERBOSE -DDEBUG=1 \
	-DLOG_KERNEL -DLV_CONF_INCLUDE_SIMPLE -D__riscv64 

C_INCLUDES := -I/home/wuliyong/Documents/kendryte-standalone-sdk-0.5.6/lib/bsp/include \
	-I/home/wuliyong/Documents/kendryte-standalone-sdk-0.5.6/lib/drivers/include \
	-I/home/wuliyong/Documents/kendryte-standalone-sdk-0.5.6/lib/utils/include 



SOURCE := \
	src/crt.S \
	src/entry_user.c \
	src/main.c 

all:ar
	$(GCC) -o $(TARGET) -L ./ -lkendryte
.PHONY=all

ar:obj
	$(AR) qc libkendryte.a crt.o main.o entry_user.o
.PHONY=ar

obj:
	$(GCC) -c $(CFLAGS) $(C_DEFINES) $(C_INCLUDES) $(SOURCE)
.PHONY:obj

clean:
	-rm -rf *.bin *.o *.a
.PHONY:clean
