%module rlibinnodb

%include "typemaps.i"

%{
#include <embedded_innodb-1.0/innodb.h>
  
typedef struct ib_trx_struct {} Transaction;
typedef struct ib_tbl_sch_struct {} TableSchema;
typedef struct ib_idx_sch_struct {} IndexSchema;
typedef struct ib_crsr_struct {} Cursor;
%}

%include "embedded_innodb-1.0/innodb.h"

%typedef struct ib_trx_struct {} Transaction;
%typedef struct ib_tbl_sch_struct {} TableSchema;
%typedef struct ib_idx_sch_struct {} IndexSchema;
%typedef struct ib_crsr_struct {} Cursor;

%extend TableSchema {
  void add_column(const char *col_name,
                  ib_col_type_t col_type,
                  ib_col_attr_t col_attr,
                  ib_ulint_t client_type,
                  ib_ulint_t len)
  {
    return ib_table_schema_add_col($self,
                                   col_name,
                                   col_type,
                                   col_attr,
                                   client_type,
                                   len);
  }
}

%extend Transaction {
  void begin(ib_trx_level_t iso_level)
  {
    $self = ib_trx_begin(iso_level);
  }

  void commit()
  {
    ib_trx_commit($self);
  }

  void lock_data_dictionary()
  {
    ib_schema_lock_exclusive($self);
  }
}

ib_err_t ib_table_schema_create(char *table_name,
                                TableSchema *OUTPUT,
                                ib_tbl_fmt_t fmt,
                                ib_ulint_t page_size);

