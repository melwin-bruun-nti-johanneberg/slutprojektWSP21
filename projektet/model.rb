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
      redirect('/login_user/:id/index')
    else
      "fel lösernord" 
    end
end 


def title()
  db = connect_to_db()
  db.results_as_hash = true 
  result = db.execute("SELECT * FROM title")
  puts result
  return result
  
end

def genre_info()
  title_id = params[:id].to_i
  db = connect_to_db()
  db.results_as_hash = true 
  result = db.execute("
    SELECT genre.genres
    From (genre_title_relation
      INNER JOIN genre ON genre_title_relation.genre_id = genre.id) 
    where title_id =?", title_id)
  return result
end 

def game_info()
  id = params[:id].to_i
  db = connect_to_db()
  db.results_as_hash = true 
  result = db.execute("SELECT * FROM title WHERE id = ?",id).first
  return result
end 

def user_info()
  db = connect_to_db()
  db.results_as_hash = true 
  id = session[:id].to_i
  result = db.execute("SELECT * FROM users WHERE id = ?",id).first
  return result

end 

#SELECT company.name, genre.genres
	#FROM ((genre_title_relation, company_title_relation
	#INNER JOIN company ON company_title_relation.company_id = company.id)
	#INNER JOIN genre ON genre_title_relation.genre_id = genre.id)
#WHERE title_id = 1