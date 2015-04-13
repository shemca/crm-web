require 'sinatra'
# require './rolodex'
require 'data_mapper'

DataMapper.setup(:default,"sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property	:first_name, String
	property	:last_name, String
	property :email, String
	property :note, String

	# attr_accessor :id, :first_name, :last_name, :email, :note

	# def initialize(first_name, last_name, email, note)
	# 	@first_name = first_name
	# 	@last_name = last_name
	# 	@email = email
	# 	@note = note
	# end
end

DataMapper.finalize
DataMapper.auto_upgrade!

# @@rolodex = Rolodex.new
# #	$rolodex = Rolodex.new
# # contact = @@rolodex.find(1000)
# @@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))
# @@rolodex.add_contact(Contact.new("Realy", "McNamerson", "real@name.com", "Totally a real person"))

get '/' do
	@crm_app_name="My CRM"
	erb :index
end

get "/contacts" do
	erb :contacts
end

get '/display' do
	@contacts = Contact.all
	erb:display
end

# get '/display' do
# 	@contacts = @@rolodex.contacts
# 	if query = params[:search]
# 		query = /#{query}/i
# 		@contacts = @contacts.select { |contact| contact.first_name =~ query }
# 	end

# 	erb :display
# end


post '/contacts' do
	new_contact = Contact.create(
		first_name: params[:first_name], 
		last_name: params[:last_name], 
		email: params[:email], 
		note: params[:note]
		)
	redirect to ('/display')
end

get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
		erb :show_contact
		
	end


get "/contacts/:id/edit" do
	@contact = Contact.get(params[:id])
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do
	@contact = Contact.get(params[:id])

	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]
	
	@contact.save

		redirect to("/display")
	else
		raise Sinatra::NotFound
	end
end

delete "/contacts/:id" do
	@contact = Contact.get(params[:id])

	if @contact
		@contact.destroy
		redirect to("/display")
	else
		raise Sinatra::NotFound
	end
end
