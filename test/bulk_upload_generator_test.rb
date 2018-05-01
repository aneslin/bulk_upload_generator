require 'minitest'
require 'minitest/autorun'
require_relative './generator_test_helpers'

class BulkUploadGeneratorTest < MiniTest::Test
	extend GeneratorTestHelpers

	generate_test_app

	Minitest.after_run do
		remove_test_app
	end
end