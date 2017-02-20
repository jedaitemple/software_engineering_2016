
require 'time'
module SRTParser

	private_class_method def self.count_el(line)
			symb=0
			symb=line.scan(/[~!@#$%^&*()\-{}\[\]|":><?\/]/)
		return symb.size
		end
		private_class_method def self.elapsed_time(line)
			line=line.gsub(/,/,".")
			line=line.gsub(/:/,"-->")
			arr=line.split("-->")
			dur=0.00
			t1 = Time.new(2016, 10, 29, 0, 0,0,"+02:00")
			t2 = Time.new(2016, 10, 29, arr[3].to_i, arr[4].to_i,arr[5].to_f,"+02:00")
			dur=t2-t1
		return dur
		end


	def self.parse_file(path_to_file)


res = Hash.new(0)
words=Array.new(0)
arr=0
num_words=0
line_len=0
symb=0
max_symb=0
cur_symb=0
max_sent=0
dur=0.00
num_subs=0
File.open(path_to_file, "r") do |f|
		  
  f.each_line do |line|
	if (line =~ /^\s*$/)
      line_len-=1
	end
		if(!line.match(/-->/) && !line.match(/\A[+-]?\d+?(\.\d+)?\Z/)  )
			
			
	 		words+=line.gsub(/[~!@#$%^&*()\-{}\[\]|”:><?\/]/, '').split
			
			line_len+=1
			symb+=count_el(line)
			cur_symb=count_el(line)
				
			max_sent+=line.scan(/[^\.!?]+[\.!?]/).count
			
		end
		if(cur_symb>max_symb)
		max_symb=cur_symb
		end
		if(line.match(/-->/))
		
			num_subs+=1
			 dur=elapsed_time(line)
			
			
		end
  end
end
	res["number_of words"]=num_words=words.size 
	res["number_of_symbols"]= symb
	res["number_of_lines"]=line_len

	if(symb/line_len.to_f%1!=0)
		res["average_symbols_per_line"]=symb/line_len.to_f.round(2)
		else
		res["average_symbols_per_line"]=symb/line_len.to_i
	end
	res["max_symbols_per_line"]=max_symb
	res["number_of_sentences"]=max_sent
	if(symb/max_sent.to_f%1!=0)
		res["average_symbol_per_sentence"]=symb/max_sent.to_f.round(2)
		else
		res["average_symbol_per_sentence"]=symb/max_sent.to_i
	end
	res["duration"]=dur.round(2)
	res["average_duration"]=(dur.round(2)/num_subs).to_f.round(2)
return  res
	
	end


	

end
