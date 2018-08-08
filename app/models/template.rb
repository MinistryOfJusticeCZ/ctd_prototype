class Template < ApplicationRecord

  enum format: DocumentGenerator::FORMATS

  def file_name
    name + '.' + format.to_s
  end

  def templates_repo_uri
    "git@git.servis.justice.cz:ctd-templates/core.git"
  end

  def working_directory
    DocumentGenerator::TEMPLATES_DIR
  end

  def directory_name
    'repo'
  end

  def repo_directory
    working_directory.join(directory_name)
  end

  def generate_directory
    Rails.root.join('tmp', 'generated_'+id.to_s)
  end

  def generate(context, input)
    fetch_git_templates
    prepare_data(context, input)

    Jekyll::Commands::Build.process(jekyll_opts)

    kit = PDFKit.new(File.new(generate_directory.join(name+'.html')))
    kit.to_pdf
  end

  def jekyll_page
    return @jekyll_page unless @jekyll_page.nil?
    fetch_git_templates
    config = jekyll_configuration
    @jekyll_page = Jekyll::Page.new(Jekyll::Site.new(config), config.source({}), '/', file_name)
  end

  def body=(value)
    jekyll_page.content = value
    File.open(repo_directory.join(file_name), 'w') do |f|
      f.write jekyll_page.data.to_yaml
      f.write "---\n"
      f.write jekyll_page.content
    end
  end

  def body
    jekyll_page.content
  end

  def html
    body
  end

  def fetch_git_templates
    if File.exists?(repo_directory)
      g = Git.open(repo_directory)
    else
      g = Git.clone(templates_repo_uri, directory_name, path: working_directory)
    end
    g.pull
  end

  def prepare_data(context, input)
    data_dir = repo_directory.join('_data')
    File.open(data_dir.join('context.json'), 'w') { |file| file.write(context.to_json) }
    File.open(data_dir.join('input.json'), 'w') { |file| file.write(input.to_json) }
  end

  def jekyll_configuration
    Jekyll.configuration(jekyll_opts)
  end

  def jekyll_opts
    {'source' => repo_directory.to_s, 'destination' => generate_directory}
  end

end
