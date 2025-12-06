class PagesController < ApplicationController

  def home()

    render({ :template => "pages_templates/index" })
  end
end
