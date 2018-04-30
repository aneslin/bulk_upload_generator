require 'rails/generators/base'
module Hyrax
	class BulkUploadGenerator < Rails::Generators::Base
		desc "Create a bulk uploader file based on an ActiveFedora model"

		argument :model, type: :string

		def generate_init
			print_model_data
		end

		private

		def print_model_data
				create_service
		end

		def get_prop_names
			prop_names = []
			 get_writable_fields.each do |line|
				 prop = {}
				 prop[:name] =  line.split(',').first
				 prop[:multiple] = line.split('multiple: ')[1].split(' ').first
				 prop_names << prop
			 end
			prop_names
		end

		def generate_write_method
			"def create_#{model.downcase} \n
				counter = 0 \n
				@photo_data.each do |#{model.downcase}_data| \n
					#{model.downcase} = #{class_name}.new \n
					#{model.downcase}.depositor = @current_user_key\n
					#{writable_attributes}
					if #{model.downcase}.save!\n
						counter += 1\n
					end\n
				end\n
				counter\n
			 end\n"
		end

		def writable_attributes
			attributes_string = ''
			get_prop_names.each do |props|
				if props[:multiple] == "true"
						attributes_string += "#{model.downcase}.#{props[:name]} = [#{model.downcase}_data[:#{props[:name]}]]\n"
				else
					attributes_string += "#{model.downcase}.#{props[:name]} = #{model.downcase}_data[:#{props[:name]}]\n"
				end
			end
			attributes_string
		end

		def create_service
			create_file "app/services/#{model.downcase}_service.rb" do
				"class #{class_name}Service\n
				#{generate_write_method}\n
				end"
			end
		end

		def class_name
			model.downcase.camelize
		end

		def get_writable_fields
			File.read("app/models/#{model}.rb").split('property :')[1..-1]
		end
	end
end
