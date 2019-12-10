require 'rails/generators/base'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module SimpleActivity
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Description: Create yml template for rules. Generate migration file for activities table. Create custom activity model(default to Activity)"

      self.source_paths << File.join(File.dirname(__FILE__), 'templates')

      def self.next_migration_number(path)
        ActiveRecord::Generators::Base.next_migration_number(path)
      end

      def create_migration_file
        migration_template "create_activities.rb", "db/migrate/create_activities.rb"
      end

      def copy_activity_model
        copy_file "common_activity.rb", "app/models/common_activity.rb"
      end
    end
  end

end
