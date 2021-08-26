require_relative '../db'

require 'csv'

County.plugin :update_or_create

# Load the input data
county_meta = CSV.foreach('loaders/source_data/county_hesitancy_and_meta.csv', headers: true).map(&:to_h)
county_meta = county_meta.map { |h| h["FIPS Code"] = h["FIPS Code"].length < 5 ? "0#{h["FIPS Code"]}" : h["FIPS Code"]; h }

# Load
county_meta.each do |meta|
  the_county = County.find(fips: meta["FIPS Code"])
  next unless the_county
  the_county.update(
    estimated_hesitant: meta["Estimated hesitant"],
    estimated_hesitant_or_unsure: meta["Estimated hesitant or unsure"],
    estimated_strongly_hesitant: meta["Estimated strongly hesitant"],
    svi: meta["Social Vulnerability Index (SVI)"],
    svi_category: meta["SVI Category"],
    level_of_concern: meta["CVAC level of concern for vaccination rollout"],
    loc_category: meta["CVAC Level Of Concern"],
    percent_hispanic: meta["Percent Hispanic"],
    percent_native_american: meta["Percent non-Hispanic American Indian/Alaska Native"],
    percent_asian: meta["Percent non-Hispanic Asian"],
    percent_black: meta["Percent non-Hispanic Black"],
    percent_api: meta["Percent non-Hispanic Native Hawaiian/Pacific Islander"],
    percent_white: meta["Percent non-Hispanic White"],
  )
end
puts "Loaded county meta"
p County.first