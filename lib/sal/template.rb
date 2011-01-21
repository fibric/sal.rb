module Sal
  # Tilt template implementation for sal
  # @api public
  class Template < Temple::Template
    engine Sal::Engine
  end

  Tilt.register 'sal', Template
end

