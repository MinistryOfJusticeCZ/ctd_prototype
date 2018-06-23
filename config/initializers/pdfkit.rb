# config/initializers/pdfkit.rb
# PDFKit.configure do |config|
#   config.wkhtmltopdf = 'xvfb-run /usr/bin/wkhtmltopdf'
#   config.default_options = {
#     :page_size => 'Legal',
#     :print_media_type => true
#   }
#   # Use only if your external hostname is unavailable on the server.
#   config.root_url = "http://localhost"
#   config.protocol = 'http'
#   config.verbose = false
# end

class PDFKit
  def executable
    'xvfb-run ' + PDFKit.configuration.wkhtmltopdf
  end
end
