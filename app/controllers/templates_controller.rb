class TemplatesController < ApplicationController

  load_and_authorize_resource

  def index
    azahara_schema_index
  end

  def show
  end

  def edit
  end

  def update
    @template.body = update_params['value']
  end

  def update_params
    params['content'].require('template').permit!
  end

end
