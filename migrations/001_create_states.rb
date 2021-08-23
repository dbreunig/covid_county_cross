Sequel.migration do
  change do
    create_table(:states) do
      String :fips, size:2, primary_key: true
      String :name, null: false
      String :abbr, size: 2
      Integer :population
      index :abbr, unique: true
    end
  end
end