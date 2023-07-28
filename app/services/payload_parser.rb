class PayloadParser

  def self.identify_payload(params)
    ParserBase.descendants.find { _1.valid? params }
  end

  def self.identify_payload!(params)
    identify_payload(params).tap do |klass|
      raise "Invalid payload" if klass.nil?
    end
  end

  def self.create_entities!(params)
    klass = identify_payload!(params)
    parser = klass.new(params)
    parser.create_entities!
  end

end
