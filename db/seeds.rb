if Product.first.nil?
    200.times do |i|
        u = Product.new
        u.title = "title"+i.to_s
        u.content = "content"+i.to_s
        u.save!
    end
end



if Story.first.nil?
    200.times do |i|
        u = Story.new
        u.title = "title"+i.to_s
        u.content = "content"+i.to_s
        u.save!
    end
end

if Permission.first.nil?
    ["stories"].each do |model|
        ["index_ajax","index","show","new","edit","create","update","destroy"].each do |operation|
            Permission.create!(:text=>model+"_"+operation,:description=>"nothing...")
        end
    end
end

if Role.first.nil?
    r=Role.new
    r.name="第一人"
    r.description="lalalal"
    Permission.all.each do |p|
        r.permissions.push(p)
    end
    p r.permissions
    r.save!
end

if Admin.first.nil?
    a=Admin.create!(:username=>"testuser",:email=>"aoxin.wang@funplus.com",:password=>"233333")
    a.role=Role.first
    a.save!
end