class Employee
  include Mongoid::Document
  include Mongoid::Search
	include Mongoid::Timestamps
  include SimpleEnum::Mongoid

  field :first_name,		  type: String
  field :last_name, 			type: String
  field :day_of_birth, 		type: DateTime
  field :place_of_birth, 	type: String
  field :salary, 					type: Float, default: 0.0
  field :experience, 			type: Integer
  field :marriage, 				type: Boolean
  as_enum :gender, [:female, :male], prefix: true, map: :string

  index({first_name: 1, last_name: 1},{name: 'first name and last name index'})

  search_in :first_name, :last_name, :place_of_birth

  has_many :computer

  
  # aggregate
  def self.test1
    # 'add_operator' => {'$add' => ['$salary', '$experience']}
    collection.aggregate([{
      '$project' => {
        'operator_test' => {
          '$divide' =>[{'$mod' => [{'$subtract' => [{'$add' => ['$salary', {'$multiply' => ['$experience', 10]}, 200 ]}, 1000 ]}, 50]}, 20]
        }
      }
    }]).first
  end

  def self.test2
    #$ year, month, week, dayOfYear, dayOfMonth, $dayOfWeek, hour, minute, second
    # 'birth_year' => {'$year' => '$day_of_birth'}
    collection.aggregate([{
      '$project' => {
        'age' => {
          '$subtract' => [{'$year' => Time.now}, {'$year' => '$day_of_birth'}]
        }
      }
    }]).first
  end

  def self.test3
    #'$substr' => ['$first_name', 0, 2] => 0, 2 mersured in byte, carefully with multibytes encoding
    collection.aggregate([{
      '$project' => {
        'code_name' => {'$substr' => ['$first_name', 0, 2]},
        'full_name' => {'$concat' => ['$first_name', ' ','$last_name']},
        'spec_name' => {'$concat' => [{'$toUpper' => '$first_name'}, {'$toLower' => '$last_name'}]}
      }
    }]).first
  end

  def self.test4
    # {$group: {'_id' => {'a' =>'$a', 'b' => '$b'}}}
    collection.aggregate([
      {
        '$group' => {
          '_id'     => '$first_name',
          'lowest'  => {'$min' => '$salary'},
          'highest' => {'$max' =>'$salary'}
        }
      }
    ]).first
  end

  def self.test5 #same as test4
    collection.aggregate([
      {
        '$sort' => {'salary' => 1}
      },
      {
        '$group' => {
          '_id'     => '$first_name',
          'lowest'  => {'$first' => '$salary'},
          'highest' => {'$last' =>'$salary'}
        }
      }
    ]).first
  end

  # logical $cmp: [expr1, expr2], strcasecmp, and/or/not
  # cond: [booExpr, true, false] ; ifNull: [expr, replacement]

end
