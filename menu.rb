require_relative 'item'
require 'pry'

class Menu

	attr_reader :goal
	attr_accessor :items, :solutions

	def initialize(goal,items)
		@goal = goal
		@items = items
		@solutions = find_solutions
	end

	def select_price(bill = Array.new,remainder = @goal)
		return bill if winner?(bill)
		return false if possible_choices(remainder).empty?

		possible_items = possible_choices(remainder)

		winning_billzz = Array.new

		possible_items.each do |item|
			new_remainder = remainder - item.price
			item_bill = bill.map(&:dup) << item
			result = select_price(item_bill,new_remainder)

			if result && !result.empty? && multiple_bills?(result)
				result.each {|sol| winning_billzz << sol.flatten}
			elsif result && !result.empty?
				winning_billzz << result.flatten
			end

		end

		winning_billzz
	end

	def remove_alt(winning_billzz)
		winning_billzz.sort!{|a,b| result_to_s(a) <=> result_to_s(b)}
		idx = 0
		while idx < winning_billzz.length-1
			if result_to_s(winning_billzz[idx]) == result_to_s(winning_billzz[idx+1])
				winning_billzz.delete_at(idx+1)
				idx = 0
			else
				idx+=1
			end
		end
		winning_billzz
	end

	def winner?(bill)
		sum = 0
		bill.each {|item| sum+=item.price}
		sum == @goal
	end

	def multiple_bills?(arr)
		arr.first.class == Array && arr[1].class == Array
	end

	def find_solutions
		possibilities = select_price
		possibilities ? remove_alt(possibilities) : []
	end

	def result_to_s(menu_selection)
		menu_selection.map{|item| item.name}.sort.join
	end

	def possible_choices(remainder)
		@items.select{|item| item.price <= remainder }
	end

	def multiple_solutions?
		@solutions.length > 1
	end

	def print_solutions
		if @solutions.empty?
			puts "Womp. No possible solutions!"
		else
			puts "                    There #{multiple_solutions? ? "are" : "is"} #{@solutions.length} possible solution#{multiple_solutions? ? "s" : ""} for a goal of $#{"%.2f" %goal}" 
			solutions.each_with_index do |solution,idx|
				puts "Solution #{idx+1}:"
				solution.each {|item| print "#{item.name} ($#{"%.2f" %item.price}) "}
				puts
			end
		end
	end

end


