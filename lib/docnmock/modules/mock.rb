module Docnmock
  module Modules
    module Mock

      def mock
        mocker.mock(self)
      end

      private

      def mocker(object_to_mock)
        Object.const_get("#{self.class.name}Mocker").new(object_to_mock)
      end
    end
  end
end
