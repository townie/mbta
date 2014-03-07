
require 'net/http'
require 'json'


uri = URI('http://realtime.mbta.com/developer/api/v1/stopsbylocation?api_key=U1N8k74hBkK874ory82gZg&lat=42.379451599999996&lon=-71.06313699999998')
req = Net::HTTP::Get.new(uri)
req['Accept'] = 'application/json'

  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end

@results = JSON.parse(res.body)



uri = URI("http://realtime.mbta.com/developer/api/v1/schedulebystop?api_key=U1N8k74hBkK874ory82gZg&stop=#{stop["stop_id"]}")
req = Net::HTTP::Get.new(uri)
req['Accept'] = 'application/json'

  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end

puts @stop = JSON.parse(res.body)


