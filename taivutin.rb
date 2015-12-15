#!/usr/bin/env ruby
# 
# Rainer, 2015-12-15

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Taivutin
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

class Substantiivi
	@@vokaalit = "aeiouyäö".split("")
	@@konsonantit = "bcdfghjklmnpqrstvwxz".split("")
	@@vokaalipääte = false

	def initialize(__word__, __erisnimi__ = nil)
		@orignal_word = __word__.downcase
		@word = __word__.downcase
		@erisnimi = __erisnimi__
		if (@erisnimi)
			@orignal_word = @orignal_word.capitalize
			@word = @word.capitalize
		end
		@@vokaalipääte = true if (@@vokaalit.include? @word[-1])
		get_stem()

	end

	def nominatiivi
		return @orignal_word

	end

	def genetiivi # -n

		if @@vokaalipääte
			return @word+@last_vowel+"n"
		else	
			return @word+"n"	
		end

	end




	private
	def get_stem()
		@word = @word.split("")
		if @@vokaalipääte
			@last_vowel = @word.pop
		
			case
			# t -> d
			when (@word[-1] == "t" && @word[-2] != "t")
				@word[-1] = "d"
				
			end

		else
			case @word.join("")
			when (/[aiä]s$/)
				@word.pop
				@word.push(@word[-1])
			when (/nen$/)
				@word = @word.join("")
				@word = @word.gsub(/nen$/, "se")
				@word = @word.split("")
					
			end
		end

		@word = @word.join("")
	end # get_stem

end


sana = Substantiivi.new("Tenhunen",true)

p sana.nominatiivi
p sana.genetiivi