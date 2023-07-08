#include project.mk

PROJECT=K210
PROJECT_DIR=$(shell pwd)
FLASH_TOOL=kflash

CFG_USART_SUPPORT = yes
CFG_FREERTOS_SUPPORT = yes

C_FLAGS += -DCONFIG_LOG_COLORS
C_FLAGS += -DCONFIG_LOG_ENABLE
C_FLAGS += -DCONFIG_LOG_LEVEL=LOG_VERBOSE
#C_FLAGS += -DLOG_KERNEL
C_FLAGS += -DDEBUG=1
C_FLAGS += -DLV_CONF_INCLUDE_SIMPLE
C_FLAGS += -D__riscv64
C_FLAGS += -mcmodel=medany
C_FLAGS += -mabi=lp64f
C_FLAGS += -march=rv64imafdc
C_FLAGS += -DCFG_USART_SUPPORT

LD_LIBS += -lc
LD_LIBS += -lm
LD_LIBS += -lstdc++

LD_FLAGS += -Wl,-u_printf_float \
	-nostartfiles -Wl,--gc-sections

PROJECT_LIB_DIR=$(PROJECT_DIR)/lib
PROJECT_LIB_BSP_DIR=$(PROJECT_LIB_DIR)/bsp
PROJECT_LIB_DRIVERS_DIR=$(PROJECT_LIB_DIR)/drivers
PROJECT_LIB_HAL_DIR=$(PROJECT_LIB_DIR)/hal

PROJECT_THIRD_PARTY_DIR=$(PROJECT_DIR)/third_party

PROJECT_SRC_DIR=$(PROJECT_DIR)/src

#INCLUDES += -I$(PROJECT_LIB_BSP_DIR)/include
#INCLUDES += -I$(PROJECT_LIB_DRIVERS_DIR)/include
#INCLUDES += -I$(PROJECT_LIB_DIR)/utils/include
#INCLUDES += -I$(PROJECT_DIR)
#INCLUDES += -I$(PROJECT_DIR)/inc

INCLUDES += -I$(PROJECT_DIR)/inc
INCLUDES += -I$(PROJECT_LIB_DIR)/arch/include
INCLUDES += -I$(PROJECT_LIB_DIR)/utils/include
INCLUDES += -I$(PROJECT_LIB_DIR)
INCLUDES += -I$(PROJECT_LIB_DIR)/bsp/include
INCLUDES += -I$(PROJECT_LIB_DIR)/hal/include
INCLUDES += -I$(PROJECT_LIB_DIR)/freertos/include
INCLUDES += -I$(PROJECT_LIB_DIR)/freertos/conf
INCLUDES += -I$(PROJECT_LIB_DIR)/freertos/portable
INCLUDES += -I$(PROJECT_THIRD_PARTY_DIR)
INCLUDES += -I$(PROJECT_THIRD_PARTY_DIR)/fatfs/source

ASM_FILES += $(PROJECT_LIB_BSP_DIR)/crt.s
C_FILES += $(PROJECT_LIB_BSP_DIR)/dump.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/entry_user.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/except.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/interrupt.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/locks.c
#C_FILES += $(PROJECT_LIB_BSP_DIR)/printf.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/sleep.c
C_FILES += $(PROJECT_LIB_BSP_DIR)/syscalls.c

CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/aes.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/dmac.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/dvp.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/fft.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/gpio.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/gpiohs.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/i2c.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/i2s.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/plic.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/pwm.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/registry.cpp
#CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/rtc.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/sccb.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/sha256.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/spi.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/timer.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/uart.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/wdt.cpp

C_FILES += $(PROJECT_LIB_BSP_DIR)/config/pin_cfg.c
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/syscalls/syscalls.cpp
CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/registry.cpp

C_FILES += $(PROJECT_SRC_DIR)/time.c
C_FILES += $(PROJECT_SRC_DIR)/log.c
C_FILES += $(PROJECT_SRC_DIR)/hello_world/main.c
#C_FILES += $(PROJECT_SRC_DIR)/time.c
#C_FILES += $(PROJECT_SRC_DIR)/log.c
C_FILES += $(PROJECT_SRC_DIR)/core_sync.c
C_FILES += $(PROJECT_SRC_DIR)/os_entry.c
C_FILES += $(PROJECT_SRC_DIR)/pthread.c
#C_FILES += $(PROJECT_SRC_DIR)/devices.c
C_FILES += $(PROJECT_SRC_DIR)/heap_4.c


#CPP_FILES += $(PROJECT_LIB_BSP_DIR)/device/registry.cpp

C_FILES += $(PROJECT_LIB_HAL_DIR)/clint.c
C_FILES += $(PROJECT_LIB_HAL_DIR)/fpioa.c
C_FILES += $(PROJECT_LIB_HAL_DIR)/sysctl.c
C_FILES += $(PROJECT_LIB_HAL_DIR)/uarths.c
C_FILES += $(PROJECT_LIB_HAL_DIR)/utility.c

LD_SCRIPT=$(PROJECT_DIR)/lds/kendryte.ld

#INCLUDES += -I$(PROJECT_DIR)/third_party

LD_FLAGS += -Wl,--wrap,printf
FREERTOS_VERSION = FreeRTOS-Kernel-V202110_00_SMP
ifeq ($(CFG_FREERTOS_SUPPORT),yes)
FREERTOS_DIR=$(PROJECT_DIR)/../freeRTOS/$(FREERTOS_VERSION)
FREERTOS_KERNEL_DIR=$(FREERTOS_DIR)/FreeRTOS-Kernel
#FREERTOS_DIR=$(PROJECT_DIR)/lib/freertos
INCLUDES += -I$(FREERTOS_KERNEL_DIR)/include
C_FILES += $(FREERTOS_KERNEL_DIR)/tasks.c
C_FILES += $(FREERTOS_KERNEL_DIR)/timers.c
C_FILES += $(FREERTOS_KERNEL_DIR)/list.c
C_FILES += $(FREERTOS_KERNEL_DIR)/queue.c

#C_FILES += $(FREERTOS_DIR)/core_sync.c

PORTABLE_DIR=$(FREERTOS_KERNEL_DIR)/portable/GCC/RISC-V
INCLUDES += -I$(PORTABLE_DIR)
INCLUDES += -I$(PORTABLE_DIR)/chip_specific_extensions/kendryte
C_FILES += $(PORTABLE_DIR)/port.c
ASM_FILES += $(PORTABLE_DIR)/portASM.s

C_FLAGS += -D__riscv_xlen=64
C_FLAGS += -DportasmHANDLE_INTERRUPT=handle_irq
endif

PROJECT_CPP_DIR=$(PROJECT_DIR)/cpp
CPP_FILES += $(PROJECT_CPP_DIR)/devices.cpp
CPP_FILES += $(PROJECT_CPP_DIR)/driver_impl.cpp
CPP_FILES += $(PROJECT_CPP_DIR)/storage/filesystem.cpp

C_FILES += $(PROJECT_THIRD_PARTY_DIR)/fatfs/source/ff.c
C_FILES += $(PROJECT_THIRD_PARTY_DIR)/fatfs/source/ffsystem.c
C_FILES += $(PROJECT_THIRD_PARTY_DIR)/fatfs/source/ffunicode.c