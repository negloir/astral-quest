# Works in GitHub Actions devkitpro/devkitarm container

TARGET   := astral_quest
SOURCES  := .
INCLUDES := .
DATA     := nitrofiles

# Use the official libnds template
include $(DEVKITPRO)/libnds/default_arm9/Makefile

# Also link libfat (needed for save/load)
LIBS := $(LIBS) -lfat
