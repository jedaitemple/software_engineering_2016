include Math

a = ARGV[0].to_f
b = ARGV[1].to_f
c = ARGV[2].to_f

if ARGV.empty?
	abort
else
	if a == 0
		if b == 0
			puts "#"
		else
			x = (-c) / b
			if x%1 == 0
				puts "#{x.to_i}"
			else
				puts "#{x.round(2)}"
			end
		end
	else
		d = b**2 - 4*a*c
		if d > 0
			x1 = (-b + Math.sqrt(d)) / (2 * a)
			x2 = (-b - Math.sqrt(d)) / (2 * a)
			if x1 > x2
				x1, x2 = x2, x1
			end
			if x1%1 == 0
				print "#{x1.to_i},"
			else
				print "#{x1.round(2)},"
			end
			if x2%1 == 0
				puts "#{x2.to_i}"
			else
				puts "#{x2.round(2)}"
			end
		elsif d == 0
				x = (-b) / (2 * a)
				if x%1 == 0
					puts "#{x.to_i}"
				else
					puts "#{x.round(2)}"
				end
		end
	end 
end