module Docnmock
  class ResourceGroup

    attr_reader :name

    def initialize(name)
      raise "Invalid group name: #{name}" unless valid_name?(name)

      @name = name
    end

    private

    def valid_name?(name)
      name.is_a? String
    end
  end
end
