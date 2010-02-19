
=begin rdoc
The Embedded InnoDB class.
=end
class InnoDB

  def initialize()
    Lib.ib_init()
  end

  def version()
    @ver = Lib.ib_api_version
  end

  def startup()
    Lib.ib_startup("barracuda")
  end

  def shutdown()
    Lib.ib_shutdown()
  end

end
