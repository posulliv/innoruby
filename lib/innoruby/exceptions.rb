
class InnoDB

=begin rdoc

Superclass for all InnoDB runtime exceptions.

=end

  class Error < RuntimeError
    attr_accessor :no_backtrace

    def set_backtrace(*args)
      @no_backtrace ? [] : super
    end

    def backtrace(*args)
      @no_backtrace ? [] : super
    end
  end

#:stopdoc:

  # Generate exception classes
  class DatabaseError < Error; self; end
  class OutOfMemory < Error; self; end
  class OutOfFileSpace < Error; self; end
  class LockWait < Error; self; end
  class DeadLock < Error; self; end

#:startdoc:
end
