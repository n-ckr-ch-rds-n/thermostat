require 'sinatra/base'
require 'json'
# require 'yajl'
require './ruby/thermostat_data.rb'


class TempAPI < Sinatra::Base

  enable :sessions

  get '/' do
    headers 'Access-Control-Allow-Origin' => '*'
    @current_city = Thermostat.latest[0].current_city
    @temperature = Thermostat.latest[0].temperature

    content_type :json
    {:current_city => "#{@current_city}", :temperature => "#{@temperature}"}.to_json

    # @current_city = Thermostat.latest[0].current_city
    # @temperature = Thermostat.latest[0].temperature
    # return @current_city + @temperature

  end

  post '/' do

  end

  run! if app_file == $0

end
