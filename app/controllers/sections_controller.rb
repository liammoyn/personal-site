class SectionsController < ApplicationController
  def index
    matching_sections = Section.all

    @list_of_sections = matching_sections.order({ :created_at => :desc })

    render({ :template => "section_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_sections = Section.where({ :id => the_id })

    @the_section = matching_sections.at(0)

    render({ :template => "section_templates/show" })
  end

  def create
    the_section = Section.new
    the_section.name = params.fetch("query_name")
    the_section.article_id = params.fetch("query_article_id")
    the_section.placement = params.fetch("query_placement")
    the_section.text_content = params.fetch("query_text_content")

    if the_section.valid?
      the_section.save
      redirect_to("/sections", { :notice => "Section created successfully." })
    else
      redirect_to("/sections", { :alert => the_section.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_section = Section.where({ :id => the_id }).at(0)

    the_section.name = params.fetch("query_name")
    the_section.article_id = params.fetch("query_article_id")
    the_section.placement = params.fetch("query_placement")
    the_section.text_content = params.fetch("query_text_content")

    if the_section.valid?
      the_section.save
      redirect_to("/sections/#{the_section.id}", { :notice => "Section updated successfully." } )
    else
      redirect_to("/sections/#{the_section.id}", { :alert => the_section.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_section = Section.where({ :id => the_id }).at(0)

    the_section.destroy

    redirect_to("/sections", { :notice => "Section deleted successfully." } )
  end
end
