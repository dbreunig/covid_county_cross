Sequel.migration do
  change do
    create_table(:county_cases) do
      primary_key :id
      Date :date, null: false
      Integer :cases, null: false
      Integer :deaths, null: false
      Integer :new_cases, default: 0
      Integer :new_deaths, default: 0
      foreign_key :county_id, :counties, type: 'varchar(5)'
      index [:county_id, :date]
    end
  end
end