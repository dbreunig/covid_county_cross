require 'sequel'

@DB = Sequel.connect('sqlite://covid_counties.db')
require_relative 'models/models'
