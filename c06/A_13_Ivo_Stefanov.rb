require 'csv'
require 'json'

def main

info = ARGV[0].to_s
task = ARGV[1].to_i

$csv = CSV.read(info)
$hash = Hash.new


case task
	
	when 1
		watch_function(1)

	when 2
		view_function(1)

	when 3
		watch_function(0)

	when 4
		view_function(0)
		
end


if task == 1 || task == 3
	x = $hash.max_by{|k,v| v}
	puts "#{x[0]},#{x[1].round(2)}"
	xHash = Hash[*x]
	fJson = File.open("temp.json","w")
	fJson.write(xHash.to_json)
	fJson.close
else
	x = $hash.max_by{|k,v| v}
	puts "#{x[0]},#{x[1]}"
	xHash = Hash[*x]
	fJson = File.open("temp.json","w")
	fJson.write(xHash.to_json)
	fJson.close
end
end

def watch_function(j)

	$csv.each do |row|

		if $hash.key?(row[j.to_i])
			$hash[row[j.to_i]] += row[2].to_f
		else
			$hash[row[j.to_i]] = row[2].to_f
		end
		
		if($hash[row[j.to_i]] % 1 != 0)
			$hash[row[j.to_i]] = $hash[row[j.to_i]].round(2)
		end
	end
	
end


def view_function(j)

	$csv.each do |row|

		if $hash.key?(row[j.to_i])
			$hash[row[j.to_i]] += 1
		else
			$hash[row[j.to_i]] = 1
		end
	end
end

main
