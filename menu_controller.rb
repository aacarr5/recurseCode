require 'pry'

module MenuController

	def make_goal(line)
		line[1..-1].to_f
	end

	def make_item(line)
		line = line.gsub(/[\\\"\n\$]/,"")
		line = line.split(",")
		Item.new(line[0],line[1].to_f)
	end

	def say_hello
		system 'clear'
		puts "Welcome to Andrew Carr's code submission!"
		sleep(2.0)
		system 'clear'
		puts "For this to work, you'll need to give a text file."
		puts "The available text files are..."
		files = Dir.entries('.')
		files = Dir.entries('.').select{|f| f.match(/\.txt$/) != nil}
		files.each {|f| puts f}
		puts 
		printf("File name: ")
	end

	def say_goodbye
		2.times{puts}
		puts "              ==================="
		puts "              Thanks for viewing!"
		puts "     Feel free to contact me at aacarr5@gmail.com"
		puts "              ==================="
	end


end