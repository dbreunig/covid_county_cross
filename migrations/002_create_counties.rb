Sequel.migration do
  change do
    create_table(:counties) do
      String :fips, size:5, primary_key: true
      String :name, null: false
      
      Integer :population

      # Vaccine Hesitancy
      Float :estimated_hesitant
      Float :estimated_hesitant_or_unsure
      Float :estimated_strongly_hesitant

      # Vaccine Vulnerability
      Float   :svi
      String  :svi_category
      Float   :level_of_concern
      String  :loc_category

      # Ethnicity
      Float   :percent_hispanic
      Float   :percent_native_american
      Float   :percent_asian
      Float   :percent_black
      Float   :percent_api
      Float   :percent_white

      foreign_key :state_id, :states, type: 'varchar(2)'
    end
  end
end