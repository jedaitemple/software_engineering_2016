require "srtparse_library/version"

module SRTParse
	def lines(subs)
	    number_lines=subs.scan(/^[ ,a-zA-Z.'!~!@#$%^&*()\-{}\[\]|”:><?]+$/)	
            return number_lines
        end		
        def subs_words_sentences(subs)
		words=subs.scan(/[a-z'A-Z]+/)            
		sentences=subs.scan(/[A-Z][^.?!]+[.?!]/m)
	        subs_count=subs.scan(/^[0-9]+$/)
                return subs_count, words,sentences 
	end
	def symbols(subs)
            number_l = lines(subs)
            symbols_count = 0
            symbols_current = 0
            max_symbols = 0
	    average_symbols=0
            number_l.each do |line|
                symbols_count += line.scan(/[~!@#$%^&*()\-{}\[\]|”:><?]/).length 
                current = line.line.scan(/[~!@#$%^&*()\-{}\[\]|”:><?]/).length
                	if(max < current)
                    	max_symbols = symbols_current
                	end		            
		end
	    average_symbols=symbols_count.to_f/number_l.to_f
	    average_symbols=average_symbols.round(2)
            return symbols_count,max_symbols,average_symbols
        end    
	def duration(subs)
            seconds = []
            durations = subs.scan(/[0-9]{2}+:[0-9]{2}+:[0-9]{2}+,[0-9]{3}+/)
            durations.each do |duration|
                times_of_duration = duration.split(':')
                time = 0
                multiplier = 3600
                duration_in_seconds = 0.0
                times_of_duration.each do |time|
                    time = time.gsub(',', '.')
                    duration_in_seconds += time.to_f * multiplier.to_f  
                    multiplier /= 60.0
                end

                duration_in_seconds = duration_in_seconds.round(2)
                seconds.push(duration_in_seconds)
            end

            return seconds
        end
        def parse_file(path)
            subs = File.read(path)
	    line_n=lines(subs)
	    durations = durations(subs) 
	    sws=subs_words_sentences(subs)
	    symbolic=symbols(subs)
	    result = {}
            result["number_of_words"] = sws[1]
            result["number_of_symbols"] = symbolic[0]
            result["number_of_lines"] = line_n
            result["average_symbols_per_line"] = symbolic[2]
            result["max_symbols_per_line"] = symbolic[1]
            result["number_of_sentences"] = sws[2]
            result["average_symbols_per_sentence"] = (symbolic[0]/ sws[2]).round(2)
            result["duration"] = durations[durations.length - 1]
            result["average_duration"] = (result["duration"].to_f / number_of_subtitle[number_of_subtitle.length - 1].to_f).round(2)
	    return result
        end 
end
