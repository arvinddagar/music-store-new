# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



obj1 = Category.create(:category_name => "major 1")
obj2 = Category.create(:category_name => "major 2")
obj3 = Category.create(:category_name => "major 3")
obj4 = Category.create(:category_name => "major 4")
obj1 = Category.create(:category_name => "minor 1", :parent_id => 1)
obj2 = Category.create(:category_name => "minor 2", :parent_id => 1)
obj3 = Category.create(:category_name => "minor 3", :parent_id => 1)
obj4 = Category.create(:category_name => "minor 4", :parent_id => 2)
obj1 = Category.create(:category_name => "minor 5", :parent_id => 2)
obj2 = Category.create(:category_name => "minor 6", :parent_id => 2)
obj3 = Category.create(:category_name => "minor 7", :parent_id => 3)
obj4 = Category.create(:category_name => "minor 8", :parent_id => 3)
obj1 = Category.create(:category_name => "minor 9", :parent_id => 3)
obj2 = Category.create(:category_name => "minor 10", :parent_id => 4)
obj3 = Category.create(:category_name => "minor 11", :parent_id => 4)
obj4 = Category.create(:category_name => "minor 12", :parent_id => 4)