require 'minitest'
require 'minitest/autorun'
require_relative './generator_test_helpers'

class BulkUploadGeneratorTest < MiniTest::Test
	extend GeneratorTestHelpers

	generate_test_app

	copy_fixtures
	copy_generator

	def test_it_creates_service
		generate_bulk_uploader
		
		assert_file 'app/services/photo_service.rb' do |content|
	    assert_match('fixtures/services/photo_service.rb', content)
	  end
	end

	Minitest.after_run do
		remove_test_app
	end
end