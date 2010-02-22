require 'helper'

class TestInnoruby < Test::Unit::TestCase

  def setup
    @inno = InnoDB.new
  end

  should "start an InnoDB instance" do
    @inno.startup
  end

  should "stop an InnoDB instance" do
    @inno.shutdown
  end

  should "create a database" do
    @inno.create_database("padraig")
  end

  should "drop a database" do
    @inno.drop_database("padraig")
  end

end
