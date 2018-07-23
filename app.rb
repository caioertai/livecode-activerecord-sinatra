require_relative "config/application"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "byebug"

get "/" do
  # Index
  @restaurants = Restaurant.all
  erb :index
end

get "/restaurant/:id" do
  # Show
  @restaurant = Restaurant.find(params[:id])
  erb :show
end

post "/restaurants" do
  # Post
  restaurant = Restaurant.create(
    name: params[:name],
    address: params[:address]
  )
  redirect to("/restaurant/#{restaurant.id}")
end
