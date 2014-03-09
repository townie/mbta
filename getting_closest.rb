stops = []
File.open('mbtastopdata.txt', 'r') do |f|

  stops = f.gets


end

puts stops

