
=begin rdoc
The Embedded InnoDB class.
=end
class InnoDB

  def initialize()
    Lib.ib_init()
    @db_error = DatabaseError.new
    @db_error.no_backtrace = true
    @out_of_mem = OutOfMemory.new
    @out_of_mem.no_backtrace = true
    @out_of_file_space = OutOfFileSpace.new
    @out_of_file_space.no_backtrace = true
    @lock_wait = LockWait.new
    @lock_wait.no_backtrace = true
    @deadlock= DeadLock.new
    @deadlock.no_backtrace = true
    @dup_key = DuplicateKey.new
    @dup_key.no_backtrace = true
    @que_thr_susp = QueueThreadSuspended.new
    @que_thr_susp.no_backtrace = true
    @missing_history = MissingHistory.new
    @missing_history.no_backtrace = true
    @clus_not_found = ClusterNotFound.new
    @clus_not_found.no_backtrace = true
    @tab_not_found = TableNotFound.new
    @tab_not_found.no_backtrace = true
    @get_more_space = MustGetMoreFileSpace.new
    @get_more_space.no_backtrace = true
    @tab_being_used = TableInUse.new
    @tab_being_used.no_backtrace = true
    @too_big_rec = RecordTooBig.new
    @too_big_rec.no_backtrace = true
    @no_ref_row = NoReferencedRow.new
    @no_ref_row.no_backtrace = true
    @cannot_add_constraint = CannotAddConstraint.new
    @cannot_add_constraint.no_backtrace = true
    @corruption = Corruption.new
    @corruption.no_backtrace = true
    @too_big_rec.no_backtrace = true
    @file_per_table = false
  end

  def version()
    @ver = Lib.ib_api_version
  end

  # Start up an InnoDB instance.
  def startup()
    check_return_code(Lib.ib_startup("barracuda"))
  end

  # Shut down an InnoDB instance.
  def shutdown()
    check_return_code(Lib.ib_shutdown())
  end

  def create_database(db_name)
    check_return_code(Lib.ib_database_create(db_name))
  end

  def drop_database(db_name)
    check_return_code(Lib.ib_database_drop(db_name))
  end

  def create_table_schema(table_name)
    ret = Lib::TableSchema.new
    check_return_code(Lib.ib_table_schema_create(table_name, 
                                                 ret,
                                                 Lib::IB_TBL_COMPACT,
                                                 0))
    ret
  end

  def delete_table_schema(tbl_sch)
    check_return_code(Lib.ib_table_schema_delete(tbl_sch))
  end

  def create_table(trx, tbl_sch)
    table_id = Integer
    check_return_code(Lib.ib_table_create(trx, tbl_sch, table_id))
    table_id
  end

  def create_transaction()
    ret = Lib::Transaction.new
    ret
  end

  def set_file_per_table(setting)
    if @file_per_table != setting
      @file_per_table = setting
      if @file_per_table == true
        check_return_code(Lib.ib_cfg_set_bool_on("file_per_table"))
      else
        check_return_code(Lib.ib_cfg_set_bool_off("file_per_table"))
      end
    end
  end

  def set_buffer_pool_size(buff_pool_size)
    check_return_code(Lib.ib_cfg_set_int("buffer_pool_size", buff_pool_size))
  end

  def set_data_file_path(path_name)
    check_return_code(Lib.ib_cfg_set_text("data_file_path", path_name))
  end

  def set_data_dir(path_name)
    check_return_code(Lib.ib_cfg_set_text("data_home_dir", path_name))
  end

  private

  # Checks the return code from Rlibinnodb against the exception list.
  # Raises the corresponding exception if the return code is not
  # InnoDB::DB_SUCCESS
  def check_return_code(ret)
    if ret == Lib::DB_SUCCESS
    elsif ret == Lib::DB_ERROR
      raise @db_error, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_OUT_OF_MEMORY
      raise @out_of_mem, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_OUT_OF_FILE_SPACE
      raise @out_of_file_space, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_LOCK_WAIT
      raise @lock_wait, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_DEADLOCK
      raise @deadlock, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_DUPLICATE_KEY
      raise @dup_key, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_QUE_THR_SUSPENDED
      raise @que_thr_susp, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_MISSING_HISTORY
      raise @missing_history, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_CLUSTER_NOT_FOUND
      raise @clus_not_found, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_TABLE_NOT_FOUND
      raise @tab_not_found, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_MUST_GET_MORE_FILE_SPACE
      raise @get_more_space, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_TABLE_IS_BEING_USED
      raise @tab_being_used, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_TOO_BIG_RECORD
      raise @too_big_rec, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_NO_REFERENCED_ROW
      raise @no_ref_row, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_CANNOT_ADD_CONSTRAINT
      raise @cannot_add_constraint, Lib.ib_strerror(ret)
    elsif ret == Lib::DB_CORRUPTION
      raise @corruption, Lib.ib_strerror(ret)
    else
    end
  end

end
