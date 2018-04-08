#ifdef ASMDEF_IDENT
#define _ASMDEF_IDENT ASMDEF_IDENT
#else
#define _ASMDEF_IDENT <ASMDEF>
#endif

// Internal support macros
#define _ASMDEF_CAT_(x, y) x ## y
#define _ASMDEF_CAT(x, y) _ASMDEF_CAT_(x, y)
#define _ASMDEF_TOKEN(uid) _ASMDEF_CAT(asmdef_, uid)
#define _ASMDEF_FUNCTOKEN _ASMDEF_CAT(_ASMDEF_CAT(_ASMDEF_TOKEN(__COUNTER__), _line_), __LINE__)
#define _ASMDEF_WRAPPER static void _ASMDEF_FUNCTOKEN(void)

#define _ASMINLINE_(ident, def, mod) asm volatile("\n" #ident " " def "\n" mod)
#define _ASMINLINE(ident, def, mod) _ASMINLINE_(ident, def, mod)
#define _ASMDEF_ASSIGN(defname, assign_val) _ASMINLINE(_ASMDEF_IDENT, #defname " = %0", :: "i" (assign_val))
#define _ASMDEF_COMMENT(comment_str) _ASMINLINE(_ASMDEF_IDENT, "",); \
                                     _ASMINLINE(_ASMDEF_IDENT, "## " comment_str,)

#define _ASMDEF_CONST(defname, val) _ASMINLINE(_ASMDEF_IDENT, #defname " = " #val,)

// Public macros
#define ASMDEF_VAL(val, defname)  \
_ASMDEF_WRAPPER {                 \
  _ASMDEF_ASSIGN(defname, val);   \
}


#define ASMDEF_CONST(val, defname)  \
_ASMDEF_WRAPPER {                   \
  _ASMDEF_CONST(defname, val);      \
}


#define ASMDEF_OFFSETOF(st, m, defname) ASMDEF_VAL(__builtin_offsetof(st, m), defname)
#define ASMDEF_SIZEOF(st, defname) ASMDEF_VAL(sizeof(st), defname)


#define ASMDEF_COMMENT(comment_str) \
_ASMDEF_WRAPPER {                   \
  _ASMDEF_COMMENT(comment_str);     \
}
