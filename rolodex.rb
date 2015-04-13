class Rolodex
	attr_reader :contacts

	def initialize
		@contacts = []
		@id = 1000
	end

	def add_contact(contact)
		contact.id = @id 
		@contacts << contact
		@id += 1
	end

	def find(contact_id)
		@contacts.find do |contact|
			contact.id == contact_id
		end	
	end

	def delete_contact(contact_id)
		if find(contact_id) == nil
			puts"Can't find id"
		else
			@contacts.delete_if do |contact|
				contact.id == contact_id
			end
	end
	end
	
	def all_attrs(attr_name)
		@contacts.map { |c| c.send(attr_name) } 
	end
	
	def remove_contact(contact)
		@contacts.delete(contact)


	end
end