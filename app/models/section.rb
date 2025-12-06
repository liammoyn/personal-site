class Section < ApplicationRecord
  belongs_to :article, required: true, class_name: "Article", foreign_key: "article_id"
end
