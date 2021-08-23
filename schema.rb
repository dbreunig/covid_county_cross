Sequel.migration do
  change do
    create_table(:divisions) do
      primary_key :key
      String :name, :size=>255, :null=>false
    end
    
    create_table(:regions) do
      primary_key :key
      String :name, :size=>255, :null=>false
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:states, :ignore_index_errors=>true) do
      String :fips, :size=>2, :null=>false
      String :name, :size=>255, :null=>false
      String :abbr, :size=>2
      Integer :population
      foreign_key :region_id, :regions
      foreign_key :division_id, :divisions
      
      primary_key [:fips]
      
      index [:abbr], :unique=>true
    end
    
    create_table(:counties) do
      String :fips, :size=>5, :null=>false
      String :name, :size=>255, :null=>false
      Integer :population
      foreign_key :state_id, :states, :type=>String, :size=>2
      foreign_key :region_id, :regions
      foreign_key :division_id, :divisions
      
      primary_key [:fips]
    end
    
    create_table(:state_cases, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Integer :cases, :null=>false
      Integer :deaths, :null=>false
      Integer :new_cases
      Integer :new_deaths
      foreign_key :state_id, :states, :type=>String, :size=>2
      
      index [:state_id, :date]
    end
    
    create_table(:state_exposures, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Float :dex, :null=>false
      Integer :num_devices, :null=>false
      foreign_key :state_id, :states, :type=>String, :size=>2
      
      index [:state_id, :date]
    end
    
    create_table(:county_cases, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Integer :cases, :null=>false
      Integer :deaths, :null=>false
      Integer :new_cases, :default=>0
      Integer :new_deaths, :default=>0
      foreign_key :county_id, :counties, :type=>String, :size=>5
      
      index [:county_id, :date]
    end
    
    create_table(:county_ethnicities) do
      primary_key :id
      Float :percent_hispanic, :null=>false
      Float :percent_native_american, :null=>false
      Float :percent_asian, :null=>false
      Float :percent_black, :null=>false
      Float :percent_api, :null=>false
      Float :percent_white, :null=>false
      foreign_key :county_id, :counties, :type=>String, :size=>5
    end
    
    create_table(:county_exposures, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Float :dex, :null=>false
      Integer :num_devices, :null=>false
      foreign_key :county_id, :counties, :type=>String, :size=>5
      
      index [:county_id, :date]
    end
    
    create_table(:county_hesitancies) do
      primary_key :id
      Float :estimated_hesitant, :null=>false
      Float :estimated_hesitant_or_unsure, :null=>false
      Float :estimated_strongly_hesitant, :null=>false
      foreign_key :county_id, :counties, :type=>String, :size=>5
    end
    
    create_table(:county_vulnerabilities) do
      primary_key :id
      Float :svi
      String :svi_category, :size=>255
      Float :level_of_concern
      String :loc_category, :size=>255
      foreign_key :county_id, :counties, :type=>String, :size=>5
    end
  end
end
