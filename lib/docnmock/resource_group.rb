module Docnmock
  class ResourceGroup

    attr_reader :name

    def initialize(name)
      raise "Invalid group name: #{name}" unless valid_name?(name)

      @name = name
      set_default_attributes
    end

    def description(new_description = nil)
      @description = new_description if new_description
      @description
    end

    private

    def valid_name?(name)
      name.is_a? String
    end

    def set_default_attributes
      @description = ""
    end

  end
end
