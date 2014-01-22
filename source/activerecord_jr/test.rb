require_relative 'app'

cohort = Cohort.find(1)
cohort[:name] = 'Best Cohort Ever'
cohort.save

# This re-queries the database, so we're checking that we actually
# saved the data as intended
p Cohort.find(1)[:name] == 'Best Cohort Ever'