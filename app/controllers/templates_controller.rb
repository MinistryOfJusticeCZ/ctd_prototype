class TemplatesController < ApplicationController

  load_and_authorize_resource

  def index
    azahara_schema_index
  end

  def show
  end

  def edit
  end

end
