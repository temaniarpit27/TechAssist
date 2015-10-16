class AskedToAnswer < ActiveRecord::Base
  belongs_to :question, class_name: "Question", foreign_key: :question_id
  belongs_to :user, class_name: "User", foreign_key: :user_id

  after_save :create_notification

  def create_notification
    text = "#{self.question.user.name} has asked you a question"
    Notification.create(:user_id => self.user_id, :question_id => self.question_id, :description => text, :seen_flag => false)
  end
end
