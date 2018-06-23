# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

module DocumentGenerator
  TEMPLATES_DIR = Rails.root.join('files')
  FORMATS = [:html, :markdown]
end
