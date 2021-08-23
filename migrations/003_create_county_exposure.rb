Sequel.migration do
  change do
    create_table(:county_exposures) do
      primary_key :id
      Date :date, null: false
      Float :dex, null: false
      Integer :num_devices, null: false
      foreign_key :county_id, :counties, type: 'varchar(5)'
      index [:county_id, :date]
    end
  end
end