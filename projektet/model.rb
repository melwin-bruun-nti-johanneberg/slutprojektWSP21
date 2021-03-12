#funktioner för DB databasen 


def connect_to_db()
    db = SQLite3::Database.new('db/Database.db')
    return db 

end 

def register_user()
    username = params[:username]
  password = params[:password]
  password_confirm = params[:password_confirm]

  if (password == password_confirm)
    password_digest = BCrypt::Password.create(password)
     db = connect_to_db()
    db.execute("INSERT INTO users (username,pwdigest) VALUES (?,?)",username,password_digest)
    redirect('/login')
    
  else
    # Fel hantering 
    "lösernorden matchade inte, var snäll och skriv igen"
    
  end

end 

def login_user()
    username = params[:username]
    password = params[:password]
    db = connect_to_db()
    db.results_as_hash = true 
    result = db.execute("SELECT * FROM users WHERE username = ?",username).first
    pwdigest = result["pwdigest"]
    id = result["id"]
  
    if BCrypt::Password.new(pwdigest) == password
      session[:id] = result["id"]
      redirect('/login_user/index')
    else
      "fel lösernord" 
    end
end 


def games_of_the_database()
  db = connect_to_db()
  db.results_as_hash = true 
  return  db.execute("SELECT * FROM title")
  
end