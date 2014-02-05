class RestPack::Serializer::Factory
  def self.create(*identifiers)
    serializers = identifiers.map { |identifier| self.classify(identifier) }
    serializers.count == 1 ? serializers.first : serializers
  end

  private

  def self.classify(identifier)
    normalised_identifier = "#{identifier.to_s.classify}"
    serializer_class = RestPack::Serializer.class_map.fetch(normalised_identifier)

    begin
      serializer_class.new
    rescue NameError
      raise "Invalid RestPack::Serializer : #{normalised_identifier}"
    end
  end
end
