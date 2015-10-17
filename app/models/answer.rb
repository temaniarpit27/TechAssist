class Answer < ActiveRecord::Base
  belongs_to :question, class_name: "::Question", foreign_key: :question_id
  belongs_to :user, class_name: "::User", foreign_key: :user_id

  has_many :comments, as: :entity, class_name: "::Comment"
	has_many :votes, as: :entity, class_name: "::Vote"

  after_save :create_notification

  def create_notification
    unless self.user_id == self.question.user_id
      text = "#{self.user.name} has answered for your question #{self.question.title[0...20]}..."
      Notification.create(:user_id => self.question.user_id, :question_id => self.question_id, :description => text, :seen_flag => false)
      text = "#{self.user.name} has answered for a question you are tagged in"
      self.question.tag_users.each do |tag_user|
        Notification.create(:user_id => tag_user.id, :question_id => self.question_id, :description => text, :seen_flag => false)
      end
    end
  end
end
