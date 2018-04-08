.code64

.include "test.asmdef"

.globl test_func
test_func:
        # This code is nonsense, but should compile (using the defs from test.asmdef)
        movq $MYCUSTOMASSEMBLYVAL, %rax
        addq $MYSTRUCTSIZE, %rax
        subq $MEMBERC_OFF, %rax
        addq $SOME_VAL, %rax
        addq $SOME_VAL_SIZE, %rax
        retq
