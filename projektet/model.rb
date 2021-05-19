#funktioner för DB databasen 
module Model

  def initialize
      @counter = Time.now  
      @index = 0 
  end 

  #Attempts to connect to databasen 
  # @return [String]
  def connect_to_db()
      db = SQLite3::Database.new('db/Database.db')
      return db 

  end 

    # Attempts to create a new user
    #
    # @param [Hash] params form data
    # @option params [String] username The username
    # @option params [String] password The password
    # @option params [String] repeat_password The repeated password
    #   @return [Hash]
    #   * :error [Boolean] whether an error occured
    #   * id [Integer] The user's ID if the user was created
    # @see Model#connect_to_db
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

  # Attempts to login user
  #
  # @param [Hash] params form data
  # @option params [String] username The username
  # @option params [String] password The password
  # 
  # @return [Integer] The ID of the user
  # @return [false] if credentials do not match a user
  def login_user()


      
      if(@counter + 120  <= Time.now)
        if (@index <= 3)
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
            @index += 1 
          
          end

        else
          "För många fel, försök igen om #{counter + 120 - Time.now}"
        end 
      end
  end 


  #if Time.now >= @last_reply_time + 300  #(seconds)
  # Reply
  # ...
 # @last_reply_time = Time.now # update the @last_reply_time last
#end


  # Finds all games in the database 
  #
  # @return [Hash]
  # * :id [Integer]  The ID of the title
  # * :name [String]  The name of the games
  # * :picture_name [String]  The picture of the game
  # * :Console [String]  The console of the games
  # * :devoloper [String]  The devolopers of the games
  # @see Model#connect_to_db
  def title()
    db = connect_to_db()
    db.results_as_hash = true 
    result = db.execute("SELECT * FROM title")
    puts result
    return result
    
  end

  # Finds the geners name and relation with the game in the database in a inner join 
  # @param [Hash] params form data
  # @option params [Integer] id The title_id (the game we are serhing for genres)
  # @return [Hash]
  # * :genres [String] The genres of the games
  # @see Model#connect_to_db
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

  # Finds one game in the database where id match 
  # @param [Hash] params form data
  # @option params [Integer] id THE game id 
  #
  # @return [Hash]
  # * :id [Integer]  The ID of the title
  # * :name [String]  The name of the games
  # * :picture_name [String]  The picture of the game
  # * :Console [String]  The console of the games
  # * :devoloper [String]  The devolopers of the games
  # @see Model#connect_to_db
  def game_info()
    id = params[:id].to_i
    session[:game_id] = params[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true 
    result = db.execute("SELECT * FROM title WHERE id = ?",id).first
    return result
  end 

  # Finds one user info in the database where id match 
  # @param [Hash] params form data  
  # @option params [Integer] id THE user id
  #
  # @return [Hash]
  # * :id [Integer]  The ID of the user
  # * :username [String]  The name of the user
  # * :pwdigest [String]  The pasword but incrypted
  # * :role [String]  The role of the user
  # @see Model#connect_to_db
  def user_info()
    db = connect_to_db()
    db.results_as_hash = true 
    id = session[:id].to_i
    result = db.execute("SELECT * FROM users WHERE id = ?",id).first
    return result

  end 

    # Attempts to insert a new row in the title_user_rel table
    #
    # @param [Hash] params form data
    # @option params [Integer] id The id of the game
    # @option params [Integer] session id The id of the user
    # @see Model#connect_to_db
  def save()
    title_id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("INSERT INTO title_user_rel (title_id,user_id) VALUES (?,?)",title_id,user_id)
    redirect("/login_user/#{user_id}/minsida")
  end 
  # Finds all games that is saved for the user in the database 
  # @param [Hash] params form data  
  # @option params [Integer] id THE user id
  #
  # @return [Hash]
  # * :id [Integer]  The ID of the title_user_rel
  # * :title_id [String]  The name of the games
  # * :user_id [Integer]  The id of the user
  # @see Model#connect_to_db
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


    # Attempts to delete a row from the title_user_rel table
    #
    # @param [Integer] id The id_rel ID
    # @param [Hash] params form data
    # @option params [Integer] user_id The id of the user
    # @option params [Integer] title_id The id of the title
    #
    # @see Model#connect_to_db
  def delete_minsdia() 
    id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("DELETE FROM  title_user_rel WHERE id_rel = ?",id)
    redirect("/login_user/#{user_id}/minsida")

  end 

    # Attempts to insert a new row in the user_list table
    #
    # @param [String] game The new game title
    # @param [Hash] params form data
    # @option params [Integer] id THE user id
    #
    # @see Model#connect_to_db
  def new_list()
    game_title = params[:game]
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("INSERT INTO user_list (game,user_id) VALUES (?,?)",game_title,user_id)
    redirect("/login_user/#{user_id}/minsida")
  end 

  # Finds all games that the user want to remeber  in the database 
  # @param [Hash] params form data  
  # @option params [Integer] id THE user id
  #
  # @return [Hash]
  # * :id [Integer]  The ID of the user_list
  # * :game [String]  The name of the game
  # * :user_id [Integer]  The id of the user
  #
  # @see Model#connect_to_db
  def user_links()
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    res = db.execute('SELECT * FROM user_list WHERE user_id = ?',user_id)
    return res
  end 

    # Attempts to delete a row from the user_list table
    #
    # @param [Integer] id The user_list ID
    # @param [Hash] params form data
    # @option params [Integer] user_id The id of the user
    # @option params [String] game The name of the game
    #
    # @see Model#connect_to_db
  def delete_list()

    id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute("DELETE FROM user_list WHERE id = ?",id)
    redirect("/login_user/#{user_id}/minsida")


  end 

    # Attempts to update a row in the user_list table
    #
    # @param [Integer] id The user_list ID
    # @param [Hash] params form data
    # @option params [Integer] user_id The id of the user
    # @option params [String] game The name of the game
    #
    # @see Model#connect_to_db
  def update()
    title = params[:title]
    id = params[:id].to_i
    user_id = session[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    db.execute('UPDATE user_list SET game=? WHERE id=?',title, id)
    redirect("/login_user/#{user_id}/minsida")
  end 

  # Finds all info about the game that match the id in the database 
  #
  # @param [Integer] id The user_list ID
  # @param [Hash] params form data
  # @option params [Integer] user_id The id of the user
  # @option params [String] game The name of the game
  #
  # @return [Hash]
  # * :id [Integer]  The ID of the user_list
  # * :game [String]  The name of the game
  # * :user_id [Integer]  The id of the user
  #
  # @see Model#connect_to_db
  def edit()
    id = params[:id].to_i
    db = connect_to_db()
    db.results_as_hash = true
    result = db.execute("SELECT * FROM user_list WHERE id = ?",id).first
    return result
  end 
end 