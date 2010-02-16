
=begin rdoc
The generated SWIG module for accessing Embedded InnoDB's C API.
=end
module Rlibinnodb
end

require 'innoruby'

class InnoDB
  Lib = Rlibinnodb
end

require 'innoruby/integer'
