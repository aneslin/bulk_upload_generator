module GeneratorTestHelpers
	def generate_test_app
		puts 'Generating rails test app...'
		system "rails new rails_test_app --skip-active-record --skip-test-unit --skip-spring --skip-bundle"
	end

	def remove_test_app
		puts 'Deleting rails test app...'
		system "rm -rf rails_test_app"
	end

	def generate_bulk_uploader
		puts 'Running rails g hyrax:bulk_upload photo'
		system "rails g hyrax:bulk_upload photo"
	end
end