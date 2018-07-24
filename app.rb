require_relative "config/application"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

# GET routes
# GETs are about retrieving and displaying data

get "/" do
  # Index action:
  # Indexes are where we show lists of things. Our restaurants
  # in this case

  # This is our home! It's like when go to 'wikipedia.org/' or
  # just 'google.com/'
  # In this case, if you `run app.rb`, our home route (root) will be
  # http://localhost:4567/

  @restaurants = Restaurant.all
  # We define an instance variable that is going to be used by our view
  # check views/index.erb if you want to recap how it was used there

  erb :index
  # We tell our controller which page we're going to render. This points it
  # to "render" a view .erb file (which stands for HTML Embedded Ruby) by the
  # name of index. views/index.erb in this case
end

get "/restaurant/:id" do
  # Show action:
  # Shows are about showing more information about a specific object
  # http://localhost:4567/restaurant/:id
  # By using this crazy ':id' in our route/controller definition, we're
  # telling Sinatra to assing in our params hash the key :id to the value
  # of whatever number we use to get to this route.
  # So, if we type http://localhost:4567/restaurant/42 in our browser,
  # sinatra will give use a params like this:
  # params
  # => {id: 42}

  @restaurant = Restaurant.find(params[:id])
  # We define an instance variable, by using the id we got from params
  # This instance variable was used in out views/show.erb to print
  # the name and address of our restaurant

  erb :show
  # We tell our controller to render a view, using erb, which has the name
  # of show. So: views/show.erb
end

# POST routes
# posts are usually about adding objects to our application

post "/restaurants" do
  # Create action:
  # Those are about adding new objects to our database
  restaurant = Restaurant.create(
    # params is a hash with value assigned to the keys we define in our form
    # go check our form in views/index.erb if you don't believe me =)
    name: params[:name],
    address: params[:address]
  )
  # Since we're in a POST action, it has no views associated to it, so
  # we need to redirect the user somewhere else after all the job (which
  # in this case was creating a new Restaurant) is done
  # We chose to send the user, after creation, to his newly created
  # restaurant, so we send him to our previously defined SHOW action
  # using the id of our new restaurant!
  redirect to("/restaurant/#{restaurant.id}")
end
