# == Schema Information
#
# Table name: sections
#
#  id           :bigint           not null, primary key
#  name         :string
#  placement    :string
#  text_content :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  article_id   :integer
#
class Section < ApplicationRecord
  has_rich_text :content
  belongs_to :article, required: true, class_name: "Article", foreign_key: "article_id"
end
