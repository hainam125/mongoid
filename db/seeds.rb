2000.times do
	e = Employee.create!(
		first_name: 				Faker::Name.first_name,
		last_name:  				Faker::Name.last_name,
		day_of_birth: 			Faker::Date.between(10.years.ago, 30.years.ago),
		place_of_birth: 		Faker::Address.city,
		salary: 						rand(50000..500000) / 100,
		experience: 				rand(0..10),
		marriage: 					rand(2) == 1,
		gender_cd: 					rand(2) < 1 ? "male" : "female"
	)
	rand(1..4).times do
		e.computers.create!(
			product_code: 			rand(1000..100000),
			name: 							Faker::App.name,
			version:  					Faker::App.version,
			author:  						Faker::App.author
		)
	end
end