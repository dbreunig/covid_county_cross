Sequel.migration do
  change do
    create_table(:counties) do
      String :fips, size:5, primary_key: true
      String :name, null: false
      Integer :population
      foreign_key :state_id, :states, type: 'varchar(2)'
    end
  end
end