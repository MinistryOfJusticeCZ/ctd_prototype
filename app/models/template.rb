class Template < ApplicationRecord

  enum format: DocumentGenerator::FORMATS

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

    Jekyll::Commands::Build.process('source' => repo_directory.to_s, 'destination' => generate_directory)

    kit = PDFKit.new(File.new(generate_directory.join(name+'.html')))
    kit.to_pdf
  end

  def fetch_git_templates
    if File.exists?(repo_directory)
      g = Git.open(repo_directory)
    else
      g = Git.clone(templates_repo_uri, directory_name, path: working_directory)
    end
    g.fetch
  end

  def prepare_data(context, input)
    data_dir = repo_directory.join('_data')
    File.open(data_dir.join('context.json'), 'w') { |file| file.write(context.to_json) }
    File.open(data_dir.join('input.json'), 'w') { |file| file.write(input.to_json) }
  end

end
