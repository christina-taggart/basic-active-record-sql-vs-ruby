require_relative 'app'

stupid_name = Student.find(24)
stupid_name[:first_name] = 'Shalaska'
stupid_name.save
p stupid_name[:first_name] == 'Shalaska'

my_cohort = Cohort.find(6)
my_cohort.save

my_cohort[:name] = 'Chargers'
my_cohort.save
p my_cohort[:name] == 'Chargers'