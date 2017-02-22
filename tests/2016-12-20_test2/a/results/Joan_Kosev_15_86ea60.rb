=begin
Develop a program named FirstName_LastName_ClassNumber_86ea60.rb

1. you are given two command line arguments;
1.1 if there are other arguments they should be discarded;
1.2 The first argument is the full path of a CSV file with 4 columns
1.3 The second argument is the full path of a JSON file

2. Find the product of all the values in the JSON file where :
 the key of this value is not equal to a value in any row on column 2 from the CSV 
 
3. Print only the result value */
=end

require 'csv'
require 'json'
 
res = 1
passed_keys = []
 
hash = JSON.parse(File.read(ARGV[1]));

CSV.foreach(ARGV[0]) do |row|
	key = row[1]
	if hash.has_key?(key) and passed_keys.include? key
		res *= hash[key].to_i
		passed_keys << key
	end
end

puts res