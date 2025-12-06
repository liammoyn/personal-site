class Article < ApplicationRecord
  belongs_to :topic, required: true, class_name: "Topic", foreign_key: "topic_id"
  has_many  :sections, class_name: "Section", foreign_key: "article_id", dependent: :destroy
end
