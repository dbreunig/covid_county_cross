class CountyVaccineStatus < Sequel::Model
  many_to_one :county
end