Sequel.migration do
  change do
    create_table(:vaccine_runs) do
      Integer :id, primary_key: true
      Boolean :counties_loaded, default: false
      Boolean :states_loaded, default: false
    end
  end
end