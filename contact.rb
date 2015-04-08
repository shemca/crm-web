class Contact
	attr_accessor :id, :first_name, :last_name, :email, :note

	def initialize(first_name, last_name, email, note)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note
	end

	def to_s
		return 	"First Name: #{@first_name}\n"+
				"Last Name: #{@last_name}\n"+
				"Email: #{@email}\n"+
				"Note: #{@note}\n"
	end
end