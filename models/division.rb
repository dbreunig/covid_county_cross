class Division < Sequel::Model
  one_to_many :state
  one_to_many :county
end
Division.unrestrict_primary_key