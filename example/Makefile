# Example CFLAGS
CFLAGS = -std=gnu89 -m64 -ffreestanding -Wno-unused-function

include ../include/asmdef.mk

ASMDEFS = $(patsubst %.asmexport, %.asmdef, $(wildcard *.asmexport))
.SECONDARY: $(ASMDEFS)

%.o: %.s
%.o: %.s $(ASMDEFS)
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
%.o: %.S $(ASMDEFS)
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@


all: example.o
