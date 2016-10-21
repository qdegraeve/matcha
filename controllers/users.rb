get '/users' do
	@users = @con.query('SELECT * FROM users')

	erb :"/users/index"
end

post '/users/new' do
	@user = @con.prepare 'INSERT INTO `users`(`login`, `email`, `password`, `first_name`, `last_name`) VALUES (?, ?, ?, ?, ?)'
	@user.execute params[:login], params[:email], params[:password], params[:first_name], params[:last_name]
	flash[:notice] = "User Succesfully created"
	redirect "/users"
end

get '/users/new' do
	erb :"users/new"
end

get '/users/login' do
	erb :"users/login"
end

post '/users/login' do
	@user = @con.prepare('SELECT * FROM users WHERE login = ? AND password = ? LIMIT 1')
	@user = @user.execute(params[:login], params[:password]).first
	if !@user
		flash[:notice] = "Wrong Login/Password"
		redirect "users/login"
	else
		session[:user_id] = @user['id']
		flash[:notice] = "Bienvenue #{@user['first_name']}"
		redirect '/users'
	end
end

get '/users/:id' do
	@user = @con.prepare 'SELECT * FROM users WHERE id = ? LIMIT 1'
	@user = @user.execute(params[:id]).first
	erb :"users/show"
end

get '/users/:id/update' do
	@user = @con.prepare 'SELECT * FROM users WHERE id = ? LIMIT 1'
	@user = @user.execute(params[:id]).first
	erb :"users/update"
end

post '/users/:id/update' do
	@user = @con.prepare 'UPDATE users SET
	login = ?,
	email = ?,
	first_name = ?,
	last_name = ?,
	sex = ?,
	interested_in = ?,
	description = ?
	WHERE id = ?'
	@user = @user.execute(params[:login], params[:email], params[:first_name], params[:last_name], params[:sex], params[:interested_in], params[:description], params[:id])
	flash[:notice] = "Profile modification done Succesfully"
	redirect "users/#{params[:id]}"
end

get '/users/:id/destroy' do
	@con.query 'DELETE FROM users WHERE id = ' + params[:id]
	redirect "/users"
end
