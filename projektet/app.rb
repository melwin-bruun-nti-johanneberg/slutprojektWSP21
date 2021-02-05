require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'

enable :sessions

#En furum som visar spel i samma genre och företag som andra spel
#samt me kommentarar på spelen 
#många i många databaser 



get('/') do
    slim(:index)
  end


