get '/' do
  # render home page
  if current_user
    redirect "/messages"
  else
    redirect "/sessions/new"
  end
  # erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @email = nil
  erb :"sessions/sign_in"
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect "/messages"
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :"sessions/sign_in"
  end
end

get '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session.clear
  200
  redirect '/'
end


#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :"sessions/sign_up"
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :"sessions/sign_up"
  end
end
