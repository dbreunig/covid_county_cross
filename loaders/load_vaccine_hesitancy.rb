require_relative '../db'

require 'csv'

# Clear the tables
CountyHesitancy.dataset.delete
CountyVulnerability.dataset.delete
CountyEthnicity.dataset.delete

# Load the input data
county_meta = CSV.foreach('loaders/source_data/county_hesitancy_and_meta.csv', headers: true).map(&:to_h)
county_meta = county_meta.map { |h| h["FIPS Code"] = h["FIPS Code"].length < 5 ? "0#{h["FIPS Code"]}" : h["FIPS Code"]; h }

# Load County Hesitancy
county_hesitancy = county_meta.map { |h| h.slice("FIPS Code", "Estimated hesitant", "Estimated hesitant or unsure", "Estimated strongly hesitant") }
county_hesitancy = county_hesitancy.map { |h| h.values }
CountyHesitancy.dataset.import(['county_id','estimated_hesitant','estimated_hesitant_or_unsure','estimated_strongly_hesitant'], county_hesitancy)
puts "#{CountyHesitancy.count} county hesitancy"
p CountyHesitancy.first

# Load County Vulerability
county_vulnerability = county_meta.map { |h| h.slice("FIPS Code", "Social Vulnerability Index (SVI)", "SVI Category", "CVAC level of concern for vaccination rollout", "CVAC Level Of Concern") }
county_vulnerability = county_vulnerability.map { |h| h.values }
CountyVulnerability.dataset.import(['county_id','svi','svi_category','level_of_concern','loc_category'], county_vulnerability)
puts "#{CountyVulnerability.count} county vulnerability"
p CountyVulnerability.first

# Load County Ethnicity
county_ethnicity = county_meta.map { |h| h.slice("FIPS Code", "Percent Hispanic", "Percent non-Hispanic American Indian/Alaska Native", "Percent non-Hispanic Asian", "Percent non-Hispanic Black", "Percent non-Hispanic Native Hawaiian/Pacific Islander", "Percent non-Hispanic White") }
county_ethnicity = county_ethnicity.map { |h| h.values }
CountyEthnicity.dataset.import(['county_id','percent_hispanic','percent_native_american','percent_asian','percent_black','percent_api','percent_white'], county_ethnicity)
puts "#{CountyEthnicity.count} county vulnerability"
p CountyEthnicity.first