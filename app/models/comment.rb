class Comment < ActiveRecord::Base
  belongs_to :user, class_name: "::User", foreign_key: :user_id
  belongs_to :entity, polymorphic: true

  after_save :create_notification

  def create_notification
    if self.entity_type == "Answer"
      text = "You have a comment on your answer #{self.entity.answer[0...20]}..."
      Notification.create(:user_id => self.entity.user_id, :question_id => self.entity.question_id, :text => text)
    else
      text = "You have a comment on question #{self.entity.title[0...20]}..."
      Notification.create(:user_id => self.entity.user_id, :question_id => self.entity_id, :text => text)
    end
  end
end
