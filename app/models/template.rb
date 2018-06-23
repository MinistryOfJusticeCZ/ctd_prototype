class Template < ApplicationRecord

  enum format: DocumentGenerator::FORMATS

  def directory
    DocumentGenerator::TEMPLATES_DIR
  end

  def generate_directory
    Rails.root.join('tmp', 'generated_'+id.to_s)
  end

  def generate(context, input)
    data_dir = directory.join('_data')
    File.open(data_dir.join('context.json'), 'w') { |file| file.write(context.to_json) }
    File.open(data_dir.join('input.json'), 'w') { |file| file.write(input.to_json) }

    Jekyll::Commands::Build.process('source' => directory.to_s, 'destination' => generate_directory)
    kit = PDFKit.new(File.new(generate_directory.join(name+'.html')))
    kit.to_pdf
  end

end
