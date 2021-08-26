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
    
    create_table(:vaccine_runs) do
      primary_key :id
      TrueClass :counties_loaded, :default=>false
      TrueClass :states_loaded, :default=>false
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
      Float :estimated_hesitant
      Float :estimated_hesitant_or_unsure
      Float :estimated_strongly_hesitant
      Float :svi
      String :svi_category, :size=>255
      Float :level_of_concern
      String :loc_category, :size=>255
      Float :percent_hispanic
      Float :percent_native_american
      Float :percent_asian
      Float :percent_black
      Float :percent_api
      Float :percent_white
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
    
    create_table(:state_vaccine_statuses, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Integer :doses_distributed, :null=>false
      Integer :doses_administered, :null=>false
      Integer :dist_per_100k, :null=>false
      Integer :admin_per_100k, :null=>false
      Integer :administered_moderna, :null=>false
      Integer :administered_pfizer, :null=>false
      Integer :administered_janssen, :null=>false
      Integer :administered_unk_manf, :null=>false
      Integer :administered_dose_1_recip, :null=>false
      Float :administered_dose_1_pop_pct, :null=>false
      Float :administered_dose_2_pop_pct, :null=>false
      Integer :administered_dose_1_recip_18_plus, :null=>false
      Float :administered_dose_1_recip_18_plus_pop_pct, :null=>false
      Integer :administered_18_plus, :null=>false
      Integer :administered_per_100k_18_plus, :null=>false
      Integer :administered_dose_1_recip_65_plus
      Float :administered_dose_1_recip_65_plus_pop_pct
      Integer :administered_65_plus
      Integer :administered_per_100k_65_plus
      Integer :administered_dose_2_recip, :null=>false
      Integer :administered_dose_2_recip_18_plus, :null=>false
      Integer :administered_dose_2_recip_18_plus_pop_pct, :null=>false
      Integer :series_complete_moderna, :null=>false
      Integer :series_complete_pfizer, :null=>false
      Integer :series_complete_janssen, :null=>false
      Integer :series_complete_unk_manuf, :null=>false
      Integer :series_complete
      Float :series_complete_pop_pct
      Integer :series_complete_18_plus
      Float :series_complete_18_plus_pop_pct
      Integer :series_complete_65_plus
      Float :series_complete_65_plus_pop_pct
      Integer :administered_12_plus
      Integer :administered_per_100k_12_plus
      Integer :administered_dose_1_recip_12_plus
      Float :administered_dose_1_recip_12_plus_pop_pct
      Integer :administered_dose_2_recip_12_plus
      Float :administered_dose_2_recip_12_plus_pop_pct
      Integer :series_complete_12_plus
      Float :series_complete_12_plus_pop_pct
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
    
    create_table(:county_exposures, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Float :dex, :null=>false
      Integer :num_devices, :null=>false
      foreign_key :county_id, :counties, :type=>String, :size=>5
      
      index [:county_id, :date]
    end
    
    create_table(:county_vaccine_statuses, :ignore_index_errors=>true) do
      primary_key :id
      Date :date, :null=>false
      Integer :series_complete_18_plus
      Float :series_complete_18_plus_pop_pct
      Integer :series_complete_65_plus
      Float :series_complete_65_plus_pop_pct
      Integer :series_complete
      Float :series_complete_pop_pct
      Integer :series_complete_12_plus
      Float :series_complete_12_plus_pop_pct
      Integer :administered_dose_1_recip
      Integer :administered_dose_1_recip_12_plus
      Integer :administered_dose_1_recip_18_plus
      Integer :administered_dose_1_recip_65_plus
      Float :administered_dose_1_pop_pct
      Float :administered_dose_1_recip_12_plus_pop_pct
      Float :administered_dose_1_recip_18_plus_pop_pct
      Float :administered_dose_1_recip_65_plus_pop_pct
      foreign_key :county_id, :counties, :type=>String, :size=>5
      
      index [:county_id, :date]
    end
  end
end
