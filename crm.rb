require 'sinatra'
require './contact'
require './rolodex'
	
	$rolodex = Rolodex.new

	get '/' do
		@crm_app_name="My CRM"
		erb :index
	end

	get "/contacts" do
		erb :contacts
	end

	get '/modify' do
		erb :modify
	end

	get '/delete' do
		erb :delete
	end

	get '/display' do
		erb :display
	end

	get 'attribute' do
		erb :attribute
	end

	post '/contacts' do
		new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
		$rolodex.add_contact(new_contact)
		redirect to ('/display')
	end