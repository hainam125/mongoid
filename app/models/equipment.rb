class Equipment
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
  field :origin, type: String
  belongs_to :computer
end
