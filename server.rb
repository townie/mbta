require 'sinatra'
require 'shotgun'
require 'pry'
require 'net/http'
require 'json'

get '/ll' do

  erb :long_lat_test
end


get '/' do

  erb :index
end

get '/test' do

  erb :test
end

post '/closeststop' do
  uri = URI("http://realtime.mbta.com/developer/api/v1/stopsbylocation?api_key=U1N8k74hBkK874ory82gZg&lat=#{params[:long]}&lon=#{params[:lat]}")
  req = Net::HTTP::Get.new(uri)
  req['Accept'] = 'application/json'

  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end

  results = JSON.parse(res.body)
  @results = results["stop"]
  @stops = []
  @results.each do |stop|
      @stops << stop["stop_id"]
 end

  erb :closeststop
end


post '/show_bus' do
  uri = URI("http://realtime.mbta.com/developer/api/v1/stopsbylocation?api_key=U1N8k74hBkK874ory82gZg&lat=#{params[:lat]}&lon=#{params[:long]}")
  req = Net::HTTP::Get.new(uri)
  req['Accept'] = 'application/json'

  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end

  results = JSON.parse(res.body)
  @results = results["stop"]
  @stop = []

  @results.each do |stop|
    uri = URI("http://realtime.mbta.com/developer/api/v1/schedulebystop?api_key=U1N8k74hBkK874ory82gZg&stop=#{stop["stop_id"]}")
    req = Net::HTTP::Get.new(uri)
    req['Accept'] = 'application/json'

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    @stop << JSON.parse(res.body)


  end

    File.open('mbtastopdata.txt', 'a+') do |f|

      f.write("\n\n\n\n\n\n\n\n\nNEW DATA from @stops\n\n\n\n\n\n\n\n\n")

      f.write(JSON.pretty_generate(@stop))
      f.write("\n\n\n\n\n\n\n\n\nNEW DATA from @results\n\n\n\n\n\n\n\n\n")
      f.write(JSON.pretty_generate(@results))
    end

  @stops = @stop
  erb :show_bus
end

# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'
