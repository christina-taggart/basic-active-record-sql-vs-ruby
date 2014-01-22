require_relative 'app'

p Cohort.find(1)[:name]
# p Cohort.find(1)[:name] == 'Best Cohort Ever'
# p Cohort.where('name = ?', 'Epsilon')[0].attributes[:id] == 5
# p Cohort.find(4).attributes[:name] == 'Gamma'

# p Student.find(1)[:first_name] == 'Lavinia'
# p Student.where('first_name = ?', 'Lavinia')[0].attributes[:id] == 1