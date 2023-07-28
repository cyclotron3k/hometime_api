class ParserBase
  # Enable/disable adapters here:
  require_dependency 'interfaces/airbnb'
  require_dependency 'interfaces/booking_dot_com'

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def create_entities!
    raise NotImplementedError
  end

  def self.valid?(params)
    JSON::Validator.validate self.const_get(:SCHEMA), params
  end

end
