# ===== Minimal libnds Makefile (no conditionals) =====
ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment.")
endif

include $(DEVKITARM)/ds_rules

TARGET      := astral_quest
SOURCES     := source
INCLUDES    := include
NITRO_FILES := nitrofiles

ARCH     := -mthumb -mthumb-interwork
CFLAGS   := -g -Wall -O2 -ffast-math -fomit-frame-pointer -march=armv5te -mtune=arm946e-s $(ARCH) $(INCLUDE) -DARM9
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions
ASFLAGS  := -g $(ARCH)
LDFLAGS  := -specs=ds_arm9.specs -g $(ARCH)
LIBS     := -lnds9 -lfilesystem -lfat
