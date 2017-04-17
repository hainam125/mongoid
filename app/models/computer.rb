class Computer
  include Mongoid::Document
  field :product_code, type: String
  field :name, type: String
  field :version
  field :author

  belongs_to :employee
  has_many :equipments
end
