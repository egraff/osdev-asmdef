AWK = gawk

# Example CFLAGS
CFLAGS = -std=gnu89 -m64 -ffreestanding -Wno-unused-function

ASMDEF_IDENT=_ASMDEF_
ASMDEF_INCLUDE = include/asmdef_macros.h

%.asmdef: %.asmexport $(ASMDEF_INCLUDE) Makefile
	$(CC) $(CFLAGS) \
	  -xc -masm=intel \
	  -D"ASMDEF_IDENT=$(ASMDEF_IDENT)" \
	  -S $< \
	  -imacros $(ASMDEF_INCLUDE) \
	  -o $(basename $@).asmdeftmp && \
	$(AWK) '/$(ASMDEF_IDENT)/{sub(/$(ASMDEF_IDENT) /,""); print > "$@" }' $(basename $@).asmdeftmp && \
	$(RM) $(basename $@).asmdeftmp


ASMDEFS = $(patsubst %.asmexport, %.asmdef, $(wildcard *.asmexport))

%.o: %.s
%.o: %.s $(ASMDEFS)
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
%.o: %.S $(ASMDEFS)
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@


all: example.o
