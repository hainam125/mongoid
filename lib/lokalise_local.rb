class LokaliseLocal
	TOKEN = ''
	ID = ''

	def test
		json_data = []
		options = {
      api_token: TOKEN,
      id: ID,
      data: json_data.to_json
    }

    response = HTTParty.post('https://lokalise.co/api/string/set', body: options)
	end

	def translate
		translation = {}
		raw_translation = YAML.load_file("config/locales/en.yml")["en"]
		process_hash(raw_translation, translation)
		translation
	end

	def process_array raw_translation, translation, outer_key
		raw_translation.each_with_index do |value, index|
			new_key = "#{outer_key}:#{index}"
			if value.is_a? Array
				process_hash value, translation, new_key
			else
				translation[new_key] = value
			end
		end
	end

	def process_hash raw_translation, translation, outer_key=''
		raw_translation.each do |key, value|
			new_key = outer_key.present? ? "#{outer_key}:#{key}" : key
			if value.is_a? Hash
				process_hash value, translation, new_key
			elsif value.is_a? Array
				process_array value, translation, key
			else
				translation[new_key] = value
			end
		end
	end

end