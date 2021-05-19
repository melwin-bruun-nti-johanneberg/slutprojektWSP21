require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require_relative './model.rb'
require 'sinatra/flash'


enable :sessions
include Model

# En websida som visar upp spel och man kan skriva ner signa egna spel om man vill. Samt spara den spel som finns på hemsidan.
#många i många databaser 


# Displays landing page 
get('/') do
    slim(:index)
  end

# Displays a login form
get('/login') do 
  slim(:login)
end 

#Attempts login and updates the session and redirect to  "/login_user/:id/index"
# @param [String] username, The username
# @param [String] password, The password
# @param [Integer] :id, the ID of the user
# @see Model#login_user
post('/login')do 
  login_user()
end 

#Displays a register form
get('/register') do 
  slim(:register)
end 

# Attempts regerister and updates the session and redirect to  '/login'
#
# @param [String] username, The username
# @param [String] password, The password
# @param [String] repeat-password, The repeated password
# @see Model#register_user

post('/users/new')do 
register_user()
end 

# Displays the page where you dont log in and just browsing the website
# @see Model#title 
get('/user/index') do 
  game = title()
  id = session[:id].to_i
  slim(:"user/index", locals:{game:game})
end 
# Displays a single game
# @param [Integer] :id, the ID of the game
# @see Model#genre_info
# @see Model#game_info
get('/user/show/:id') do 
  genre = genre_info()
  game = game_info()
  slim(:"user/show", locals:{game:game, genre:genre})
end 

# Displays the login users games page where he looking at games
# @param [Integer] :id, the ID of the user
# @see Model#title
# @see Model#user_info
get('/login_user/:id/index') do 
  game = title()
  user = user_info()
  slim(:"login_user/index", locals:{game:game, user:user})
end 

# Attempts to save a game article to user personal page and there relation and redirects to '/login_user/:id/minsida'
# @param [Integer] :id, the ID of the game
# @see Model#save
post('/login_user/show/login_user/save/:id') do 
  save()
end 
# Displays a single game
# @param [Integer] :id, the ID of the game
# @see Model#genre_info
# @see Model#game_info
# @see Model#user_info
get('/login_user/show/:id') do 
  genre = genre_info()
  game = game_info()
  user = user_info()
  slim(:"login_user/show", locals:{game:game, genre:genre, user:user})
end 


# Deletes an existing game on my page and redirects to '/login_user/:id/minsida'
#
# @param [Integer] :id, The ID of the game
#
# @see Model#delete_minsdia
post('/login_user/:id/delete') do 
  delete_minsdia() 
end 

# Creates a new game and redirects to '/login_user/:id/minsida'
#
# @param [Integer] :id, The ID of the game
# @param [String] game, The title of the game
#
# @see Model#new_list
post('/login_user/minsida') do 
  new_list()
end 

# 
# @param [Integer] :id, the ID of the user
# @see Model#saves
# @see Model#user_links
# @see Model#user_info
get('/login_user/:id/minsida') do 
  user = user_info()
  sida = saves()
  list = user_links()
  slim(:"login_user/minsida", locals:{user:user, sida:sida, list:list})
end 

# Deletes an existing game and redirects to '/login_user/:id/minsida'
#
# @param [Integer] :id, The ID of the game
#
# @see Model#delete_list
post('/login_user/list/:id/delete') do
  delete_list()
end 


# Updates an existing game title and redirects to '/login_user/:id/minsida'
#
# @param [Integer] :id, the ID of the game
# @param [String] title, The new title of the article
#
# @see Model#update
post('/login_user/:id/update') do 
 update()
end 

# Displays edit form
# @param [Integer] :id, the ID of the game
# @see Model#edit
get('/login_user/minsida/:id/edit') do 
  edit = edit()
slim(:"login_user/edit", locals:{res:edit})
end 