
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
  class DuplicateKey < Error; self; end
  class QueueThreadSuspended < Error; self; end
  class MissingHistory < Error; self; end
  class ClusterNotFound < Error; self; end
  class TableNotFound < Error; self; end
  class MustGetMoreFileSpace < Error; self; end
  class TableInUse < Error; self; end
  class RecordTooBig < Error; self; end
  class LockWaitTimeout < Error; self; end

#:startdoc:
end
