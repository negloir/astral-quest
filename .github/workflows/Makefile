# Build in current dir (.github/workflows)
ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment.")
endif

include $(DEVKITARM)/ds_rules

TARGET      := astral_quest
BUILD       := build
SOURCES     := source
INCLUDES    := include
NITRO_FILES := nitrofiles

ARCH     := -mthumb -mthumb-interwork
CFLAGS   := -g -Wall -O2 -ffast-math -fomit-frame-pointer -march=armv5te -mtune=arm946e-s $(ARCH)
CFLAGS   += $(INCLUDE) -DARM9
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions
ASFLAGS  := -g $(ARCH)
LDFLAGS  := -specs=ds_arm9.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)

LIBS     := -lnds9 -lfilesystem -lfat
LIBDIRS  := $(LIBNDS)

ifneq ($(BUILD),$(notdir $(CURDIR)))
export OUTPUT   := $(CURDIR)/$(TARGET)
export VPATH    := $(foreach dir,$(SOURCES),$(CURDIR)/$(dir))
export DEPSDIR  := $(CURDIR)/$(BUILD)
CFILES   := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES   := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))

ifeq ($(strip $(CPPFILES)),)
  export LD := $(CC)
else
  export LD := $(CXX)
endif

export OFILES := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)
export INCLUDE  := -iquote $(CURDIR)/$(INCLUDES) -I$(LIBNDS)/include -I$(CURDIR)/$(BUILD)
export LIBPATHS := -L$(LIBNDS)/lib

.PHONY: $(BUILD) clean
$(BUILD):
	@[ -d $@ ] || mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile
clean:
	@rm -fr $(BUILD) $(TARGET).elf $(TARGET).nds
else
$(OUTPUT).nds: $(OUTPUT).elf $(NITRO_FILES)
	@ndstool -c $@ -9 $(TARGET).elf -d $(NITRO_FILES)
$(NITRO_FILES): ; @:
$(OUTPUT).elf: $(OFILES)
	@$(LD) $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) -o $@
%.o: %.c
	@$(CC) -MMD -MF $(DEPSDIR)/$*.d $(CFLAGS) -c $< -o $@
%.o: %.cpp
	@$(CXX) -MMD -MF $(DEPSDIR)/$*.d $(CXXFLAGS) -c $< -o $@
%.o: %.s
	@$(CC) -MMD -MF $(DEPSDIR)/$*.d $(ASFLAGS) -c $< -o $@
endifexport DEPSDIR  := $(CURDIR)/$(BUILD)

CFILES    := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES  := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES    := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
BINFILES  := $(foreach dir,$(DATA),$(notdir $(wildcard $(dir)/*.*)))
PNGFILES  := $(foreach dir,$(GRAPHICS),$(notdir $(wildcard $(dir)/*.png)))

ifeq ($(strip $(CPPFILES)),)
  export LD := $(CC)
else
  export LD := $(CXX)
endif

export OFILES_SOURCES := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)
export OFILES_BINARIES := $(addsuffix .o,$(BINFILES))
export OFILES := $(OFILES_BINARIES) $(OFILES_SOURCES)

export HFILES := $(addsuffix .h,$(subst .,_,$(BINFILES))) \
                 $(addsuffix .h,$(subst .,_,$(PNGFILES)))

export INCLUDE  := $(foreach dir,$(INCLUDES),-iquote $(CURDIR)/$(dir)) \
                   $(foreach dir,$(LIBDIRS),-I$(dir)/include) \
                   -I$(CURDIR)/$(BUILD)
export LIBPATHS := $(foreach dir,$(LIBDIRS),-L$(dir)/lib)

.PHONY: $(BUILD) clean

$(BUILD):
	@[ -d $@ ] || mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

clean:
	@echo clean ...
	@rm -fr $(BUILD) $(TARGET).elf $(TARGET).nds

else

$(OUTPUT).nds: $(OUTPUT).elf $(NITRO_FILES)
	@ndstool -c $@ -9 $(TARGET).elf -d $(NITRO_FILES)
	@echo built ... $(notdir $@)

$(NITRO_FILES):
	@:

$(OUTPUT).elf: $(OFILES)
	@echo linking $(notdir $@)
	@$(LD) $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) -o $@

%.o: %.c
	@echo $(notdir $<)
	@$(CC) -MMD -MF $(DEPSDIR)/$*.d $(CFLAGS) -c $< -o $@

%.o: %.cpp
	@echo $(notdir $<)
	@$(CXX) -MMD -MF $(DEPSDIR)/$*.d $(CXXFLAGS) -c $< -o $@

%.o: %.s
	@echo $(notdir $<)
	@$(CC) -MMD -MF $(DEPSDIR)/$*.d $(ASFLAGS) -c $< -o $@

%.bin.o: %.bin
	@echo $(notdir $<)
	@$(bin2o)

endif
