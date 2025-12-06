class Topic < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :notes, class_name: "Note", foreign_key: "topic_id", dependent: :destroy
  has_many  :articles, class_name: "Article", foreign_key: "topic_id", dependent: :destroy

  validates :name, presence: true
end
