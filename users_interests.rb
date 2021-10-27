require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def total_users
    @users.keys.size
  end

  def total_interests
    interests = 0
    @users.each do |_, data|
      interests += data[:interests].size
    end

    interests
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/:name" do
  @name = params[:name].to_sym
  erb :user_page
end

=begin
{
  :jamy =>   {:email=>"jamy.rustenburg@gmail.com",
              :interests=>["woodworking", "cooking", "reading"]},
  :nora =>   {:email=>"nora.alnes@yahoo.com", 
              :interests=>["cycling", "basketball", "economics"]},
  :hiroko => {:email=>"hiroko.ohara@hotmail.com",
              :interests=>["politics", "history", "birding"]}
}
=end