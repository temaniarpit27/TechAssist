class Answer < ActiveRecord::Base
  belongs_to :question, class_name: "::Question", foreign_key: :question_id
  belongs_to :user, class_name: "::User", foreign_key: :user_id

  has_many :comments, as: :entity, class_name: "::Comment"
	has_many :votes, as: :entity, class_name: "::Vote"

  after_save :create_notification

  def create_notification
    text = "#{self.user.name} has answered for your question #{self.question.title[0...20]}..."
    Notification.create(:user_id => self.user_id, :question_id => self.question_id, :text => text)
  end
end
