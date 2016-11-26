if Product.first.nil?
    200.times do |i|
        u = Product.new
        u.title = "title"+i.to_s
        u.content = "content"+i.to_s
        u.save!
    end
end

if User.first.nil?
    User.create!(:username=>"testuser",:email=>"aoxin.wang@funplus.com",:password=>"233333")
end

if Story.first.nil?
    200.times do |i|
        u = Story.new
        u.title = "title"+i.to_s
        u.content = "content"+i.to_s
        u.save!
    end
end