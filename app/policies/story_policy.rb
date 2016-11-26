class StoryPolicy < ApplicationPolicy
    def update?
        false  #测试禁止更新
    end
end