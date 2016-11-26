require 'test_helper'
require 'generators/rails/model_config/model_config_generator'

class Rails::ModelConfigGeneratorTest < Rails::Generators::TestCase
  tests Rails::ModelConfigGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
