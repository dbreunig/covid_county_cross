
require_relative '../db'

# Compute new cases and set
system("sqlite3 covid_counties.db 'UPDATE county_cases set new_cases = daily.new_cases, new_deaths = daily.new_deaths FROM (SELECT x.id as id, cases - LAG(cases,1) OVER (PARTITION BY fips ORDER BY date) as new_cases, deaths - LAG(deaths,1) OVER (PARTITION BY fips ORDER BY date) as new_deaths FROM counties c JOIN county_cases x ON c.fips = x.county_id) as daily WHERE daily.id = county_cases.id;'")
puts "Case rates updated"
p CountyCase.last