class People
  include Mongoid::Document
  include SimpleEnum::Mongoid
  field :first_name, type: String
  field :last_name, type: String
  field :transaction, type: Hash
  as_enum :gender, [:female, :male], prefix: true, map: :string
end
