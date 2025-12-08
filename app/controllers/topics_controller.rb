require "bundler/setup"
require "ai-chat"
require "dotenv/load"

class TopicsController < ApplicationController
  def index
    matching_topics = Topic.where({ :user_id => current_user.id })

    @list_of_topics = matching_topics.order({ :created_at => :desc })

    render({ :template => "topic_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_topics = Topic.where({ :id => the_id })

    @the_topic = matching_topics.first
    @list_of_notes = Note.where({ :topic_id => the_id })

    @list_of_ideas = [ { :description => "Something about dogs" }, { :description => "Maybe a thought piece on zebras" } ]
    @list_of_articles = Article.where({ :topic_id => the_id })

    render({ :template => "topic_templates/show" })
  end

  def generate
    user_description = params.fetch("query_description")

    topic_generation_system_prompt = "You are a tool for generating ideas for topics for articles students can write using the notes they have acquired. You will read user descriptions of the topic they want to write about and format it into a title and short description. The title should be short and use the same language that the user provides in their prompt. The description should be no more than two sentences and clarify the specific part of the topic the articles will focus on. The description should describe the topic, not any specific article written about the topic."
    topic_generation_schema = <<~JSON
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "type": "object",
      "properties": {
        "title": {
          "type": "string"
        },
        "description": {
          "type": "string"
        }
      },
      "required": ["title", "description"],
      "additionalProperties": false
    }
    JSON

    c = AI::Chat.new
    c.system(topic_generation_system_prompt)
    c.user(user_description)
    c.schema = topic_generation_schema

    ai_response = c.generate!
    data = ai_response[:content]

    the_topic = Topic.new
    the_topic.name = data[:title]
    the_topic.description = data[:description]
    the_topic.user_id = current_user.id

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics/#{the_topic.id}", { :notice => "Topic created successfully." })
    else
      redirect_to("/", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def create
    the_topic = Topic.new
    the_topic.name = params.fetch("query_name")
    the_topic.description = params.fetch("query_description")
    the_topic.user_id = current_user.id

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics", { :notice => "Topic created successfully." })
    else
      redirect_to("/topics", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_topic = Topic.where({ :id => the_id }).at(0)

    the_topic.name = params.fetch("query_name")
    the_topic.description = params.fetch("query_description")
    the_topic.user_id = current_user.id

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics/#{the_topic.id}", { :notice => "Topic updated successfully." } )
    else
      redirect_to("/topics/#{the_topic.id}", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_topic = Topic.where({ :id => the_id }).at(0)

    the_topic.destroy

    redirect_to("/topics", { :notice => "Topic deleted successfully." } )
  end
end
