require_relative 'menu'
require_relative 'menu_controller'
include MenuController

items = []
goal = 0

MenuController::say_hello

txt_file = gets.chomp

raise ArgumentError.new("Doesn't appear to be a valid file. Try again!") if txt_file.match(/\.txt$/) == nil

File.open(txt_file,'r').each do |line|
	line.include?(",") ? items << MenuController::make_item(line) : goal+= MenuController::make_goal(line)
end

menu = Menu.new(goal,items)

menu.print_solutions

MenuController.say_goodbye


