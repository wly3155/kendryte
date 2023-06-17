#include project.mk

PROJECT=K210
PROJECT_DIR=$(shell pwd)

C_FLAGS += -DCONFIG_LOG_COLORS
C_FLAGS += -DCONFIG_LOG_ENABLE
C_FLAGS += -DCONFIG_LOG_LEVEL=LOG_VERBOSE 
C_FLAGS += -DDEBUG=1
C_FLAGS += -DLOG_KERNEL
C_FLAGS += -DLV_CONF_INCLUDE_SIMPLE
C_FLAGS += -D__riscv64

C_FLAGS += -mcmodel=medany
C_FLAGS += -mabi=lp64f
C_FLAGS += -march=rv64imafc

LD_LIBS += -lm

LD_FLAGS += -Wl,-u_printf_float \
	-nostartfiles -Wl,--gc-sections

PROJECT_LIB_DIR=$(PROJECT_DIR)/lib
PROJECT_LIB_BSP_DIR=$(PROJECT_LIB_DIR)/bsp
PROJECT_LIB_DRIVERS_DIR=$(PROJECT_LIB_DIR)/drivers

PROJECT_SRC_DIR=$(PROJECT_DIR)/src

INCLUDES += -I$(PROJECT_LIB_BSP_DIR)/include
INCLUDES += -I$(PROJECT_LIB_DRIVERS_DIR)/include
INCLUDES += -I$(PROJECT_LIB_DIR)/utils/include

ASM_FILES += $(PROJECT_LIB_BSP_DIR)/crt.s
C_FILES += $(PROJECT_LIB_BSP_DIR)/entry_user.c
C_FILES += $(PROJECT_SRC_DIR)/main.c

C_FILES += $(PROJECT_LIB_BSP_DIR)/interrupt.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/syscalls.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/printf.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/locks.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/sleep.c

C_FILES += $(PROJECT_LIB_DRIVERS_DIR)/fpioa.c
C_FILES += $(PROJECT_LIB_DRIVERS_DIR)/plic.c
C_FILES += $(PROJECT_LIB_DRIVERS_DIR)/uart.c
C_FILES += $(PROJECT_LIB_DRIVERS_DIR)/clint.c
C_FILES += $(PROJECT_LIB_DRIVERS_DIR)/sysctl.c

LD_SCRIPT=$(PROJECT_DIR)/lds/kendryte.ld