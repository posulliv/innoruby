
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
  end

  def version()
    @ver = Lib.ib_api_version
  end

  # Start up an InnoDB database.
  # Raises <b>InnoDB::OutOfMem</b> if we run out of memory.
  def startup()
    check_return_code(Lib.ib_startup("barracuda"))
  end

  def shutdown()
    check_return_code(Lib.ib_shutdown())
  end

  def set_buffer_pool_size(buff_pool_size)
    check_return_code(Lib.ib_cfg_set_int("buffer_pool_size", buff_pool_size))
  end

  def set_data_file_path(path_name)
    check_return_code(Lib.ib_cfg_set_text("data_file_path", path_name))
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
    else
    end
  end

end
