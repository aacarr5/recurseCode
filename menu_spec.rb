require 'rspec'
require_relative 'menu'

describe 'the full menu class' do

	let (:item1) {Item.new("orange",5)}
	let (:item2) {Item.new("banana",3)}
	let (:item3) {Item.new("chicken",9)}
	let (:item4) {Item.new("carrot",2)}
	
	let (:menu) {Menu.new(10,[item1,item2,item3,item4])}


	it 'should return possible choices for next purchase' do
		choices = menu.possible_choices(5)
		choices.map!{|item| item.price}.sort
		expect(choices).to eq([5,3,2])
	end

	it 'should know if a potential bill\'s sum is the total price' do
		expect(menu.winner?([item1,item2,item4])).to eq(true)
	end

	it 'should have no repeating combations' do
		new_menu = Menu.new(5,[item1,item2,item4])
		expect(new_menu.solutions.length).to eq(2) 
	end

	it 'should be able to deal impossible goals' do
		new_menu = Menu.new(1,[item1,item2])
		expect{new_menu.print_solutions}.to output("Womp. No possible solutions!\n").to_stdout
	end



end