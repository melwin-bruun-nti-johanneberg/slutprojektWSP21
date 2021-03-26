require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require_relative './model.rb'

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
  
  slim(:"user/index", locals:{game:game})
end 

get('/user/show') do 
  slim(:"user/show")
end 

get('/login_user/index') do 
  slim(:"login_user/index")
end 

get('/login_user/show') do 
  slim(:"login_user/show")
end 

get('/login_user/minsida')do 
  slim(:"login_user/minsida")
end 