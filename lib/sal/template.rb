module Sal
  # Tilt template implementation for sal
  # @api public
  Template = Temple::Templates::Tilt(Sal::Engine, :register_as => :sal)

  if Object.const_defined?(:Rails)
    RailsTemplate = Temple::Templates::Rails(Sal::Engine,
                                             :register_as => :sal,
                                             :generator => Temple::Generators::RailsOutputBuffer,
                                             :disable_capture => true)
  end
end

