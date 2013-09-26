module Docnmock
  module Modules
    module Mock

      def mock
        mocker.mock
      end

      private

      def mocker
        Object.const_get("#{self.class.name}Mocker").new(self)
      end
    end
  end
end
