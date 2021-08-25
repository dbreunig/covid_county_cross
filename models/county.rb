class County < Sequel::Model
  many_to_one :state
  many_to_one :region
  many_to_one :division

  one_to_many :county_dexes, order: :date
  one_to_many :county_cases, order: :date
  one_to_many :county_vaccine_status, order: :date
  one_to_one :county_ethnicity
  one_to_one :county_hesitancy
  one_to_one :county_vulnerability

  dataset_module do
    def all_cases
      select()
    end
  end
end
County.unrestrict_primary_key