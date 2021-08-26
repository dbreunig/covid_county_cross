namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect('sqlite://covid_counties.db') do |db|
      Sequel::Migrator.run(db, "migrations", target: version)
    end
    Rake::Task["db:dump"].invoke
    puts "Migration complete"
  end

  desc "Delete the db"
  task :destroy, [:version] do |t, args|
    File.delete('covid_counties.db')
  end

  desc "Load source data"
  task :load, [:version] do |t, args|
    require_relative 'loaders/load_counties_and_states'
    puts "Counties and states loaded"
    require_relative 'loaders/load_dex'
    puts "DEX loaded"
    require_relative 'loaders/load_cases_and_deaths'
    puts "Cases and deaths loaded"
    require_relative 'loaders/load_county_hesitancy'
    puts "County hesitancy loaded"
    require_relative 'loaders/load_census_figures'
    puts "Census statistics loaded"
    require_relative 'loaders/calculate_case_changes'
    puts "Daily case changes calculated"
    require_relative 'loaders/load_vax_backfill'
    puts "Vaccine statuses loaded"
  end

  desc "Update temporal data"
  task :update, [] do |t, args|
    require_relative 'loaders/update_vax_status'
  end

  desc "Bounce and load db"
  task :bounce, [] do |t, args|
    Rake::Task["db:destroy"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:load"].invoke
  end

  desc "Dump current db schema"
  task :dump, [] do |t, args|
    require "sequel"
    Sequel.connect('sqlite://covid_counties.db') do |db|
      db.extension :schema_dumper
      File.write("schema.rb", db.dump_schema_migration)
    end
  end

end