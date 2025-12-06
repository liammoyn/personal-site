class ArticlesController < ApplicationController
  def index
    matching_articles = Article.all

    @list_of_articles = matching_articles.order({ :created_at => :desc })

    render({ :template => "article_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_articles = Article.where({ :id => the_id })

    @the_article = matching_articles.at(0)

    render({ :template => "article_templates/show" })
  end

  def create
    the_article = Article.new
    the_article.topic_id = params.fetch("query_topic_id")
    the_article.title = params.fetch("query_title")
    the_article.summary = params.fetch("query_summary")

    if the_article.valid?
      the_article.save
      redirect_to("/articles", { :notice => "Article created successfully." })
    else
      redirect_to("/articles", { :alert => the_article.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_article = Article.where({ :id => the_id }).at(0)

    the_article.topic_id = params.fetch("query_topic_id")
    the_article.title = params.fetch("query_title")
    the_article.summary = params.fetch("query_summary")

    if the_article.valid?
      the_article.save
      redirect_to("/articles/#{the_article.id}", { :notice => "Article updated successfully." } )
    else
      redirect_to("/articles/#{the_article.id}", { :alert => the_article.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_article = Article.where({ :id => the_id }).at(0)

    the_article.destroy

    redirect_to("/articles", { :notice => "Article deleted successfully." } )
  end
end
