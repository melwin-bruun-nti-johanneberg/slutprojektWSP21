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


