#display all users - users#index
get '/' do
  redirect '/users/new'
end

get '/users' do

end

#return form for new user - users#new
get '/users/new' do
  erb :login
end

#create a new user - users#create
post '/users' do
  @user = User.find_by(username: params[:username])
  if @user
    if @user.password == params[:password]
      redirect '/users/#{@user.id}'
    else

# Sign-in

#         @errors = ["Password does not match"]
#         erb :_login
#       end
#     else
#       @errors = ["Username not found"]
#       erb :_login
#     end

#   else
#     @errors = ["Password required"]
#     erb :_login
#   end
# end


  else

  # @user = User.new(username: params[:username], password: params[:password], email: params[:email], high_score: 0)
  # if params[:password].length > 0
  #   if @user.save
  #     log_in(@user)
  #     erb(:game, locals: {user: @user})
  #   else
  #     @errors = @user.errors.full_messages
  #     erb :_login
  #   end
  # else
  #   @errors = ["No password entered"]
  #   erb :_login
  # end
    if @user.save
      redirect '/users/:id'
    else
      redirect '/users/new'
    end



end


post '/sessions' do
end

#display specific user - users#show
get '/users/:id' do
end

get '/signout' do
  log_out
  erb :_login
end

# **Sign up**
# - Users can create a new account for our site.
#   - If sign up is successful, a new user is created and the user is taken to their profile page.
#   - If sign up fails, the user is taken back to the sign up page and given information about what went wrong.

# **Sign in**
# - Users with accounts can sign into their accounts.
#   - If sign in is successful, the user is taken to their profile page.
#   - If sign in fails, the user is taken back to the sign in page and given information about what went wrong.

# **Sign out**
# - After signing in, users can sign out.
