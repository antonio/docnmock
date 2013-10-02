module Docnmock
  class ResourceGroupMocker < Struct.new(:resource_group)

    def mock
      resource_group.resources.each do |resource|
        ResourceMocker.new(resource).mock
      end
    end

  end
end
