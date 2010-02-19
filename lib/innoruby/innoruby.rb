
=begin rdoc
The Embedded InnoDB class.
=end
class InnoDB

  def initialize()
  end

  def version()
    @ver = Lib.ib_api_version
  end

end
