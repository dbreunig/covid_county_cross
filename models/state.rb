class State < Sequel::Model
  one_to_many :counties
  many_to_one :region
  many_to_one :division

  one_to_many :state_exposures
  one_to_many :state_cases
end
State.unrestrict_primary_key