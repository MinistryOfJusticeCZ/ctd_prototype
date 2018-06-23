class Context < ApplicationRecord

  serialize :variables, DocumentGenerator::VariablesCoder

end
