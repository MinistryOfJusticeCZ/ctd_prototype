module Api
  module V1
    class DocumentsController < ApiController

      api :POST, '/templates/:template_id/documents', 'Generates document from defined template'
      param :context, Hash, desc: 'Context variables'
      param :input, Hash, desc: 'User input'
      # error :code => 403, :desc => "Unauthorized"
      error :code => 404, :desc => "Template to generate document was not found"
      def create
        @template = Template.find(params[:template_id])
        send_data @template.generate(params[:context], params[:input]), filename: "#{@template.name}.pdf", type: 'application/pdf'
      end

    end
  end
end
