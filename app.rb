require 'sinatra'
require 'mqtt'

configure do
  set :host, ENV['MQTT_HOST']
  set :username, ENV['MQTT_USER']
  set :password, ENV['MQTT_PASS']
  set :action, ENV['MQTT_ACTION']
end

def execute(command)
  MQTT::Client.connect(:remote_host => settings.host, :username => settings.username, :password => settings.password) do |c|
    c.publish('message', '{"devices":["' + settings.action + '"], "payload": {"command":"' + command + '"}}')
  end
end

get '/' do
  erb :index
end

post '/channel_up' do
  execute("channel_up")
  redirect '/'
end

post '/channel_down' do
  execute("channel_down")
  redirect '/'
end

post '/tv_power' do
  execute("tv_power")
  redirect '/'
end
