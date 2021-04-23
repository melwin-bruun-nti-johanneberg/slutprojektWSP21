require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require_relative './model.rb'
require 'sinatra/flash'

enable :sessions

#En furum som visar spel i samma genre och företag som andra spel
#samt me kommentarar på spelen 
#många i många databaser 



get('/') do
    slim(:index)
  end


get('/login') do 
  slim(:login)
end 

post('/login')do 
login_user()
end 

get('/register') do 
  slim(:register)
end 

post('/users/new')do 
register_user()
end 

get('/user/index') do 
  game = title()
  id = session[:id].to_i
  slim(:"user/index", locals:{game:game})
end 

get('/user/show/:id') do 
  genre = genre_info()
  game = game_info()
  slim(:"user/show", locals:{game:game, genre:genre})
end 

get('/login_user/:id/index') do 
  game = title()
  user = user_info()
  slim(:"login_user/index", locals:{game:game, user:user})
end 


post('/login_user/show/login_user/save/:id') do 
  save()
end 

get('/login_user/show/:id') do 
  genre = genre_info()
  game = game_info()
  user = user_info()
  slim(:"login_user/show", locals:{game:game, genre:genre, user:user})
end 

get('/login_user/:id/minsida') do 
  user = user_info()
  slim(:"login_user/minsida", locals:{user:user})
end 

