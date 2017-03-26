json.extract! employee, :id, :first_name, :last_name, :day_of_birth, :salary, :experience, :marriage, :created_at, :updated_at
json.url employee_url(employee, format: :json)