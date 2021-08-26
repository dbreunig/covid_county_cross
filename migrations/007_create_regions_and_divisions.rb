Sequel.migration do
  change do
    create_table(:regions) do
      Integer :key, primary_key: true
      String :name, null: false
    end
    create_table(:divisions) do
      Integer :key, primary_key: true
      String :name, null: false
    end
    alter_table(:counties) do
      add_foreign_key :region_id, :regions
      add_foreign_key :division_id, :divisions
    end
    alter_table(:states) do
      add_foreign_key :region_id, :regions
      add_foreign_key :division_id, :divisions
    end
  end
end