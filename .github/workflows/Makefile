# Minimal Makefile (works in devkitpro/devkitarm container)
TARGET      := astral_quest
SOURCES     := .
INCLUDES    := .
DATA        := nitrofiles
ARCH        := -mthumb -mthumb-interwork
CFLAGS      := -g -Wall -O2 -ffast-math -fno-strict-aliasing $(ARCH) $(INCLUDE)
CXXFLAGS    := $(CFLAGS) -fno-rtti -fno-exceptions
ASFLAGS     := -g $(ARCH)
LDFLAGS     := -specs=ds_arm9.specs -g $(ARCH)
NITROFSDIR  := nitrofiles
include $(DEVKITPRO)/devkitARM/nds_rules
