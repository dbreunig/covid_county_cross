class CountyHesitancy < Sequel::Model
  many_to_one :county
end