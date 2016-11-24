# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# if Story.first.nil?
#     200.times do |i|
#         u = Story.new
#         u.title = "title"+i.to_s
#         u.author = "Pollack"+i.to_s
#         u.text="2333333"
#         u.save
#     end
# end


if Product.first.nil?
    200.times do |i|
        u = Product.new
        u.title = "title"+i.to_s
        u.content = "content"+i.to_s
        u.save!
    end
end

