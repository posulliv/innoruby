
=begin rdoc
The generated SWIG module for accessing Embedded InnoDB's C API.
=end
module Innoruby
end

require 'innoruby'

class InnoDB
  Lib = Innoruby
end

require 'innoruby/integer'
