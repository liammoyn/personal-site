# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  summary    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#
class Article < ApplicationRecord
  belongs_to :topic, required: true, class_name: "Topic", foreign_key: "topic_id"
  has_many  :sections, class_name: "Section", foreign_key: "article_id", dependent: :destroy
end
