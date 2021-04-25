#funktioner för DB databasen 
module Model

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
        redirect("/login_user/#{id}/index")
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
    session[:game_id] = params[:id].to_i
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

  def save()
    title_id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("INSERT INTO title_user_rel (title_id,user_id) VALUES (?,?)",title_id,user_id)
    redirect("/login_user/#{user_id}/minsida")
  end 

  def saves()
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    result = db.execute("SELECT * 
      FROM (title_user_rel 
        INNER JOIN title ON title_user_rel.title_id = title.id)
        WHERE user_id =?", user_id)
    return result
  end 

  def delete_minsdia() 
    id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("DELETE FROM  title_user_rel WHERE id_rel = ?",id)
    redirect("/login_user/#{user_id}/minsida")

  end 


  def new_list()
    game_title = params[:game]
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("INSERT INTO user_list (game,user_id) VALUES (?,?)",game_title,user_id)
    redirect("/login_user/#{user_id}/minsida")
  end 

  def user_links()
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    res = db.execute('SELECT * FROM user_list WHERE user_id = ?',user_id)
    return res
  end 

  def delete_list()

    id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("DELETE FROM user_list WHERE id = ?",id)
    redirect("/login_user/#{user_id}/minsida")


  end 

  def update()
    title = params[:title]
    id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute('UPDATE user_list SET game=? WHERE id=?',title, id)
    redirect("/login_user/#{user_id}/minsida")
  end 

  def edit()
    id = params[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    result = db.execute("SELECT * FROM user_list WHERE id = ?",id).first
    return result
  end 
end 