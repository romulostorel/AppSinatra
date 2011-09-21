require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'sass'
require 'haml'

#conexão banco
DataMapper.setup(:default, "mysql://root:root@localhost/sinat")

#classe produto
class Product
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :status, String
  def self.active
    all(:status => "A")
  end
end

#lista produtos
get '/' do
  @products = Product.all
  haml :index
end

get '/product/new' do
haml :new, :locals => {
     :c => Product.new,
     :action => 'create'
   }
end

post '/product/create' do
  c = Product.new
  c.attributes = params
  c.save
  redirect("/")
end

delete '/product/:id' do |id|
  c = Product.get(id)
  c.destroy
  redirect "/"
end
