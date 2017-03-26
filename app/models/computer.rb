class Computer
  include Mongoid::Document
  field :product_code, type: String

  belongs_to :employee
end
