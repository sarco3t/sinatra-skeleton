require 'dotenv/load'
require 'sequel'
require 'rspec/core/rake_task'

namespace :g do
  desc 'Creates new migration'
  task :migration, :name do |_t, args|
    fname = "migrations/#{DateTime.now.strftime('%Y%m%d%H%M%S')}_#{args[:name]}.rb"
    File.open(fname, 'w') do |f|
      f.write(
        "Sequel.migration do\n\nend"
      )
    end
    puts "File was created #{fname}"
  end
end
namespace :db do
  Sequel.extension :migration
  DB = Sequel.connect(ENV['DATABASE_URL'])

  desc 'Prints current schema version'
  task :version do
    version = DB[:schema_info].first[:version] if DB.tables.include?(:schema_info) || 0

    puts "Schema Version: #{version}"
  end

  desc 'Perform migration up to latest migration available'
  task :migrate do
    Sequel::Migrator.run(DB, 'migrations')
    Rake::Task['db:version'].execute
  end

  desc 'Perform rollback to specified target or full rollback as default'
  task :rollback, :target do |_t, args|
    args.with_defaults(target: 0)

    Sequel::Migrator.run(DB, 'migrations', target: args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc 'Perform migration reset (full rollback and migration)'
  task :reset do
    Sequel::Migrator.run(DB, 'migrations', target: 0)
    Sequel::Migrator.run(DB, 'migrations')
    Rake::Task['db:version'].execute
  end
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end
