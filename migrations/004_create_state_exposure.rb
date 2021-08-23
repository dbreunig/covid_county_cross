Sequel.migration do
  change do
    create_table(:state_exposures) do
      primary_key :id
      Date :date, null: false
      Float :dex, null: false
      Integer :num_devices, null: false
      foreign_key :state_id, :states, type: 'varchar(2)'
      index [:state_id, :date]
    end
  end
end