module Docnmock
  class ApiMocker < Struct.new(:api)

    def mock
      api.resource_groups.each { |rg| rg.mock }
    end

  end
end
