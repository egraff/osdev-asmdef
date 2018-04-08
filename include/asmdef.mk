THIS_MK := $(CURDIR)/$(lastword $(MAKEFILE_LIST))
THIS_DIR := $(shell dirname $(THIS_MK))

CFLAGS ?= -std=gnu89

AWK = gawk

ASMDEF_IDENT=_ASMDEF_
ASMDEF_INCLUDE = $(THIS_DIR)/asmdef_macros.h

%.asmdeftmp: %.asmexport $(ASMDEF_INCLUDE) $(THIS_MK)
	$(CC) $(CFLAGS) \
	  -xc -masm=intel \
	  -D"ASMDEF_IDENT=$(ASMDEF_IDENT)" \
	  -S $< \
	  -imacros $(ASMDEF_INCLUDE) \
	  -o $@

%.asmdef: %.asmdeftmp Makefile
	$(AWK) '/$(ASMDEF_IDENT)/{sub(/$(ASMDEF_IDENT) /,""); print > "$@" }' $<
