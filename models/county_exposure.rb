class CountyExposure < Sequel::Model
  many_to_one :county
end