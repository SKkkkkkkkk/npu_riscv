#include "universal_caller.h"
#include <stddef.h>

#if 0
/* Test mixing different scalar argument types */
float test_mixed_types(char a1, short a2, int a3, long long a4, float a5,
                        double a6, void *a7) {
  return (int8_t)a1 + a2 + a3 + a4 + a5 + a6 + (intptr_t)a7;
}


static func_t test_mixed_types_func = {
  .func = test_mixed_types,
  .ret_type = RET_FLOAT,
  .arg_count = 7,
  .args = (arg_t[]){{ARG_CHAR, {.c = -1}}, {ARG_SHORT, {.s = -2}},
                    {ARG_INT, {.i = 30000}},
                    {ARG_LONG_LONG, {.ll = 400000LL}},
                    {ARG_FLOAT, {.f = -5.5f}},
                    {ARG_DOUBLE, {.d = 6.6}},
                    {ARG_POINTER, {.p = (void *)7}}}
};

int main() {
  return_value_t res;
  *(func_t**)(0xf0300000 + 0x160) = &test_mixed_types_func;
  res = universal_caller(*(func_t**)(0xf0300000 + 0x160));
  *(float*)(0xf0300000 + 0x164) = res.f;
  return 0;
}
#else

int main() {
  (void)universal_caller(*(func_t**)(0xf0300000 + 0x160));
  __builtin_unreachable();
  return 0;
}

#endif
