
=begin rdoc
The Embedded InnoDB class.
=end
class InnoDB

  def initialize()
  end

  def version()
    @ver = ib_api_version()
  end

end
