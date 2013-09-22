module Docnmock
  class Resource
    class Example < Struct.new(:path, :response, :parameters)

      def initialize(path, response, parameters = {})
        super
        check_attributes!
      end

      def check_attributes!
        self.each_pair do |attr_name, attr_value|
          raise "Missing attribute: #{attr_name}" unless attr_value
        end
      end

    end
  end
end
