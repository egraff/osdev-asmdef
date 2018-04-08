AWK = gawk

# Example CFLAGS
CFLAGS = -std=gnu89 -m64 -ffreestanding -Wno-unused-function

ASMDEF_IDENT=_ASMDEF_
ASMDEF_INCLUDE = include/asmdef_macros.h

%.asmdeftmp: %.asmexport $(ASMDEF_INCLUDE) Makefile
	$(CC) $(CFLAGS) \
	  -xc -masm=intel \
	  -D"ASMDEF_IDENT=$(ASMDEF_IDENT)" \
	  -S $< \
	  -imacros $(ASMDEF_INCLUDE) \
	  -o $@

%.asmdef: %.asmdeftmp Makefile
	$(AWK) '/$(ASMDEF_IDENT)/{sub(/$(ASMDEF_IDENT) /,""); print > "$@" }' $<


ASMDEFS = $(patsubst %.asmexport, %.asmdef, $(wildcard *.asmexport))
.SECONDARY: $(ASMDEFS)

%.o: %.s
%.o: %.s $(ASMDEFS)
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
%.o: %.S $(ASMDEFS)
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@


all: example.o
