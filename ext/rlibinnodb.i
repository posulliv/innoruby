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

ib_err_t ib_table_schema_create(char *table_name,
                                TableSchema *OUTPUT,
                                ib_tbl_fmt_t fmt,
                                ib_ulint_t page_size);
