require 'test_helper'
require 'generators/extra_route/asher_generator'

class AsherGeneratorTest < Rails::Generators::TestCase
  tests AsherGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
