#include <R.h>
#include <Rinternals.h>
#include <stdlib.h>
#include <Rmath.h>
#include <R_ext/Rdynload.h>

void hydrus();

extern SEXP hydrus1d_c(){
  hydrus();
  return R_NilValue;
}

static const R_CallMethodDef CallEntries[] = {
  {"hydrus1d_c", (DL_FUNC) &hydrus1d_c, 0},
  {NULL,       NULL,                0}
};

void R_init_hydrus1d(DllInfo *dll){
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
