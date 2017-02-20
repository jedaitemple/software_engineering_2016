class SRTParse
	
	def seconds_time(line)
		time = 0
		sec = 0.00
		line = line.gsub(/,/, ".")
		line = line.gsub(/--> /, ':')
		time = line.split(/:/)
		sec = time[3].to_i * 3600 + time[4].to_i * 60 + time[5].to_f
		return sec
	end 
	
	def avr_sums (hash_with_sol)
		avr_sum = hash_with_sol["number_of_symbols"].to_f/ hash_with_sol["number_of_lines"].to_f 
		hash_with_sol["average_symbols_per_line"] = avr_sum.round(2)
		avr_sum_sentence = hash_with_sol["number_of_symbols"].to_f / hash_with_sol["number_of_sentences"].to_f
		hash_with_sol["average_symbols_per_sentence"] = avr_sum_sentence.round(2)

	end	
	
	def parse_file(sub_file)
		hash_with_sol = Hash.new(0)
		sec_time = 0.00
		sub_count = 0
			File.open(sub_file, "r") do |file|
			file.each_line do |line|	
				if line.match(/--> /) 
				sec_time = seconds_time(line)
				sub_count += 1
				end	

				if  line.match( /[[[:upper:]][[:lower:]]]/)
				hash_with_sol["number_of_words"] += line.gsub(/[[:punct:]]/, '').split.size
				hash_with_sol["number_of_symbols"] += line.scan(/[~!@\#$%^&*()\-{}\[\]|":><?\/]/).count 
				hash_with_sol["number_of_lines"] += 1
					if 	hash_with_sol["max_symbols_per_line"] < line.split(/[~!@\#$%^&*()\-{}\[\]|":><?\/]/).size - 1 
						hash_with_sol["max_symbols_per_line"] = line.split(/[~!@\#$%^&*()\-{}\[\]|":><?\/]/).size - 1
					end  
				hash_with_sol["number_of_sentences"] += line.split(/[^\.?!][\.?!]/).size - 1
				end	
			end		
			end
	avr_sums (hash_with_sol)
	hash_with_sol["duration"] = sec_time.to_f.round(2)
	hash_with_sol["average_duration"] = (sec_time.to_f.round(2) / sub_count).round(2)
	return hash_with_sol	
	end
end  
