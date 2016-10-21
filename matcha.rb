require 'sinatra'
require 'mysql2'
require 'require_all'
require 'sinatra/flash'

require_all 'models'
require_all 'controllers'

enable :sessions

before do
	Mysql2::Client.default_query_options.merge!(:symbolize_key => :true)
	@con = Mysql2::Client.new(:host => "localhost", :database => "matcha")
end

get '/' do
	erb :index
end

get '/:name' do
	@name = params[:name]
	erb :show
end

post '/:name' do
	@name = params[:name] + "Beau Gosse"
	erb :show
end

