class StateVaccineStatus < Sequel::Model
  many_to_one :state
end