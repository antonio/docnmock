module Docnmock
  class Parameter

    VALID_ATTRS = [:name, :type, :required, :description]
    attr_reader(*VALID_ATTRS)

    def initialize(attributes)
      check_attributes! attributes

      defaults.merge(attributes).each do |name, value|
        self.instance_variable_set(:"@#{name}", value)
      end
    end

    private

    def defaults
      { name: '',
        type: '',
        required: false,
        description: '' }
    end

    def check_attributes!(attributes)
      attributes.each_key do |attr|
        raise "Invalid attribute: #{attr}" unless valid_attribute? attr
      end
    end

    def valid_attribute?(attribute)
      VALID_ATTRS.include? attribute
    end

  end
end
