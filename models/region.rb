class Region < Sequel::Model
  one_to_many :state
  one_to_many :county
end
Region.unrestrict_primary_key