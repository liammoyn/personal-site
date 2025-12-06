class Note < ApplicationRecord
  belongs_to :topic, required: true, class_name: "Topic", foreign_key: "topic_id"
end
