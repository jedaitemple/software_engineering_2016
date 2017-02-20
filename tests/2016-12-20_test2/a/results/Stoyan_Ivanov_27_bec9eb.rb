=begin
Develop a program named FirstName_LastName_ClassNumber_bec9eb.rb

1. you are given two arguments;
1.1 if there are other arguments they should be discarded;
1.2 The second argument is to a JSON file
1.3 The third argument is to an XML file
2. Find the number of nodes in the xml that have a name equal to a key in the JSON file
3. Calculate the square of this number
4. Print only the result value
=end

require 'json'
require 'crack'
require 'rubygems'

json = JSON.parse File.read(ARGV[1])
xml = Crack::XML.parse(File.read(ARGV[2]))

result = 0
equal = 0

xml.each do |key, value|
	equal = 0
	json.each do |k,v|
		if (key == k)
			equal = equal + 1
		end
	end
	
	if (equal > 1)
		result = result + 1
	end
end

result = result * result

puts result
