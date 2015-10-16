class Vote < ActiveRecord::Base
  belongs_to :user, class_name: "::User", foreign_key: :user_id
  belongs_to :entity, polymorphic: true
end
