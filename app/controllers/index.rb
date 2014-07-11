get '/' do
  session[:message] = nil
  erb :index
end

get '/signup' do
	erb :signup
end

post '/signup' do
	@current_user = User.new(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], 
                           email: params[:email], password: params[:password])
	if params[:password] != params[:confirm_password]
		session[:message] = "Your password confirmation did not match.  Please try again."
	  redirect back
	elsif @current_user.save
	  session[:message] = nil
	  session[:user_id] = @current_user.id
	  redirect '/'
	else
	 	session[:message] = "Sign up failed.  Please try again."
	 	redirect back
	 end
end

get '/login' do
	erb :login
end

post '/login' do
@current_user = User.authenticate(params[:email], params[:password])
  if @current_user
    session[:message] = nil
    session[:user_id] = @current_user.id
    redirect "/users/#{session[:user_id]}"
  else
    session[:message] = "Log in failed. Please try again or create an account."
    redirect back
  end
end

get '/users/:user_id' do
  erb :profile
end

get '/logout' do
	session[:user_id] = nil
	erb :index
end
