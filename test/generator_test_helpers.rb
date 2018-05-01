module GeneratorTestHelpers
	def generate_test_app
		puts 'Generating rails test app...'
		system "rails new rails_test_app --skip-active-record --skip-test-unit --skip-spring --skip-bundle"
	end

	def copy_fixtures
		system 'cp -a test/fixtures/controllers/. rails_test_app/app/controllers/'
		system 'cp -a test/fixtures/models/. rails_test_app/app/models/'
	end

	def copy_generator
		system 'mkdir -p rails_test_app/lib/hyrax/bulk_upload'
		system 'cp lib/hyrax/bulk_upload/bulk_upload_generator.rb rails_test_app/lib/hyrax/bulk_upload/bulk_upload_generator.rb'
	end

	def remove_test_app
		puts 'Deleting rails test app...'
		system "rm -rf rails_test_app"
	end

	def generate_bulk_uploader
		puts 'Running rails g hyrax:bulk_upload photo'
		puts 'Running rails g hyrax:bulk_upload oral_history'
		system "rails g hyrax:bulk_upload photo"
		system "rails g hyrax:bulk_upload oral_history"
	end
end