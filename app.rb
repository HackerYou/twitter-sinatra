require 'sinatra'
require 'dotenv'
Dotenv.load

get '/tweets/by/:handle' do |handle|
  tweets = client.user_timeline(handle).take(3)

  erb :handle, locals: {handle: handle, tweets: tweets}
end

get '/tweets/about/:topic' do |topic|
  tweets = client.search(topic).take(3)

  erb :topic, locals: {topic: topic, tweets: tweets}
end

def client
  require 'twitter'
  @client ||= Twitter::REST::Client.new(
    consumer_key:    ENV['TWITTER_KEY'],
    consumer_secret: ENV['TWITTER_SECRET']
  )
end
