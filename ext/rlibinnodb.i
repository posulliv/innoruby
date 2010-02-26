%module rlibinnodb

%include "typemaps.i"

%{
#include <embedded_innodb-1.0/innodb.h>
  
typedef struct ib_trx_struct {} Transaction;
typedef struct ib_tbl_sch_struct {} TableSchema;
typedef struct ib_idx_sch_struct {} IndexSchema;
typedef struct crsr_struct {} Cursor;

%}

%include "embedded_innodb-1.0/innodb.h"

%typedef struct ib_trx_struct {} Transaction;
%typedef struct ib_tbl_sch_struct {} TableSchema;
%typedef struct ib_idx_sch_struct {} IndexSchema;
%typedef struct crsr_struct {} Cursor;

%extend TableSchema {
  void add_column(const char *col_name,
                  ib_col_type_t col_type,
                  ib_col_attr_t col_attr,
                  ib_u16_t client_type,
                  ib_ulint_t len)
  {
    return ob_table_schema_add_col($self,
                                   col_name,
                                   col_type,
                                   col_attr,
                                   client_type,
                                   len);
  }
}

ib_err_t ib_table_schema_create(char *table_name,
                                TableSchema *OUTPUT,
                                ib_tbl_fmt_t fmt,
                                ib_ulint_t page_size);
