class Block < ApplicationRecord

  enum format: DocumentGenerator::FORMATS

  serialize :variables, DocumentGenerator::VariablesCoder

end
