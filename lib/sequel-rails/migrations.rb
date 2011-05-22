require 'sequel/extensions/migration'

class Sequel::Migrator
  public :migration_version_from_file
  public_class_method :migrator_class
end

module Rails
  module Sequel
    class Migrations
      def self.migrate_up!(version=nil)
        opts = {}
        opts[:target] = version.to_i if version
        
        with_logger do
          ::Sequel::Migrator.run(::Sequel::Model.db, "db/migrate", opts)
        end
      end
      
      def self.migrate_down!(version=nil)
        opts = {}
        if version
          opts[:target] = version.to_i
        else
          klass = ::Sequel::Migrator.migrator_class("db/migrate").new(::Sequel::Model.db, "db/migrate")
          filename = klass.ds.order(klass.column).reverse.limit(1,1).get(klass.column)
          opts[:target] = klass.migration_version_from_file(filename)
        end

        with_logger do
          ::Sequel::Migrator.run(::Sequel::Model.db, "db/migrate", opts)
        end
      end
      
    private

      def self.with_logger
        logger = MigrationsLogger.new
        ::Sequel::Model.db.loggers << logger
        yield
      ensure
        ::Sequel::Model.db.loggers.delete logger
      end

    end

    class MigrationsLogger
      def initialize(output=$stdout)
        @migrating = false
        @output = output
      end

      def bold(string)
        @output.tty? ? "\e[1m#{string}\e[0m" : string
      end

      def log(string)
        if string =~ /^Begin applying migration/
          @output.puts bold(string)
          @migrating = true
        elsif string =~ /^Finished applying migration/
          @output.puts bold(string)
          @migrating = false
        elsif @migrating
          @output.puts string
        end
      end

      alias_method :info, :log
      alias_method :warn, :log
      alias_method :error, :log
    end

  end
end
