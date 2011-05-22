require 'sequel/extensions/migration'

module Rails
  module Sequel
    class Migrations

      class << self
        
        def migrate_up!(version=nil)
          opts = {}
          opts[:target] = version.to_i if version
          
          
          
          ::Sequel::Migrator.run(::Sequel::Model.db, "db/migrate", opts)
        end
        
        def migrate_down!(version=nil)
          opts = {}
          if version
            opts[:target] = version.to_i
          else
            klass = ::Sequel::Migrator.send(:migrator_class, "db/migrate").new(::Sequel::Model.db, "db/migrate")
            filename = klass.ds.order(klass.column).reverse.limit(1,1).get(klass.column)
            opts[:target] = klass.send(:migration_version_from_file, filename)
          end

          ::Sequel::Migrator.run(::Sequel::Model.db, "db/migrate", opts)
        end
        
      end
      
      
    end
  end
end
