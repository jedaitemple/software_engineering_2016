require 'csv'
require 'json'

csv_path = ARGV[0].to_s
json_path = ARGV[1].to_s

json1 = File.read(json_path)

json = JSON.parse(json1)

CSV.foreach(csv_path) do |row|
	json.each do |key|
		if min < row[key[1]].to_i
			min = row
		end
	end
end

puts min
