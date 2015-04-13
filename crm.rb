require 'sinatra'
require './contact'
require './rolodex'
	
@@rolodex = Rolodex.new
#	$rolodex = Rolodex.new
# contact = @@rolodex.find(1000)
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))
@@rolodex.add_contact(Contact.new("Realy", "McNamerson", "real@name.com", "Totally a real person"))

get '/' do
	@crm_app_name="My CRM"
	erb :index
end

get "/contacts" do
	erb :contacts
end

get '/display' do
	@contacts = @@rolodex.contacts
	if query = params[:search]
		query = /#{query}/i
		@contacts = @contacts.select { |contact| contact.first_name =~ query }
	end

	erb :display
end


post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to ('/contacts')
end

get "/contacts/:id" do
	@contact = @@rolodex.find(params[:id].to_i)
		erb :show_contact
		
	end


get "/contacts/:id/edit" do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

put "/contacts/:id" do
	@contact = @@rolodex.find(params[:id.to_i])

	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]
	
		
	else
		raise Sinatra::NotFound
	end
end

delete "/contacts/:id" do
	@contact = @@rolodex.find(params[:id].to_i)

	if @contact
		@@rolodex.remove_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end
