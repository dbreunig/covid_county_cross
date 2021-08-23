Sequel.migration do
  change do
    # Vaccine Hesitancy
    create_table(:county_hesitancies) do
      primary_key :id
      Float :estimated_hesitant,            null: false
      Float :estimated_hesitant_or_unsure,  null: false
      Float :estimated_strongly_hesitant,   null: false
      foreign_key :county_id, :counties, type: 'varchar(5)'
    end
    # Vaccine Vulnerability
    create_table(:county_vulnerabilities) do
      primary_key :id
      Float   :svi
      String  :svi_category
      Float   :level_of_concern
      String  :loc_category
      foreign_key :county_id, :counties, type: 'varchar(5)'
    end
    # County Hesitancy
    create_table(:county_ethnicities) do
      primary_key :id
      Float   :percent_hispanic, null: false
      Float   :percent_native_american, null: false
      Float   :percent_asian, null: false
      Float   :percent_black, null: false
      Float   :percent_api, null: false
      Float   :percent_white, null: false
      foreign_key :county_id, :counties, type: 'varchar(5)'
    end
  end
end