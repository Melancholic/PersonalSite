require 'logger'
def read_contacts()
	file = Rails.root.join('config').join('contacts.yml');  
	if (File.exist?(file) )
		contacts=YAML.load(File.read(file))
	else
		File.write(file, "# Add your contact details below. For example:\n#\tphone: \"123-45-67\"")
		Rails.logger.info("File with contacts not found, create new at \"#{file.to_s}\"")
	end	
	
	if (contacts) 
		Rails.logger.info("File with contacts successfully loaded")
		contacts.symbolize_keys  
	else
		Rails.logger.info("Contacts file is empty or contains an error. See \"#{file.to_s}\"") 
		{}
	end
end
HomeSite::Contacts = read_contacts
