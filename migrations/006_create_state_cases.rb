Sequel.migration do
  change do
    create_table(:state_cases) do
      primary_key :id
      Date :date, null: false
      Integer :cases, null: false
      Integer :deaths, null: false
      Integer :new_cases
      Integer :new_deaths
      foreign_key :state_id, :states, type: 'varchar(2)'
      index [:state_id, :date]
    end
  end
end