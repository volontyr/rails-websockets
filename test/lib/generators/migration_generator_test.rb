require 'test_helper'
require 'generators/migration/migration_generator'

class MigrationGeneratorTest < Rails::Generators::TestCase
  tests MigrationGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
