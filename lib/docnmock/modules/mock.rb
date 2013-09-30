require 'active_support/inflector'

module Docnmock
  module Modules
    module Mock

      def mock
        mocker.mock
      end

      private

      def mocker
        "#{self.class.name}Mocker".constantize.new(self)
      end
    end
  end
end
