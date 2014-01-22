require_relative 'app.rb'

cohort = Cohort.find(1)
cohort[:name] = 'Best Cohort Ever'
cohort.save
Cohort.all
#new_cohort = Cohort.create(name: 'Spencers_Team')
#new_cohort.save
where_cohort = Cohort.where('name = ?', 'Spencers_Team')

student = Student.find(2000)
student[:first_name] = 'Chaz'
student.save
Student.all
#new_student = Student.create(cohort_id: 10, first_name: 'Spencer', last_name: 'Smitherman', email: 'spencersmitherman@boss.com',
#                             gender: 'm', birthdate: '1990-04-10')
#new_student.save
where_student = Student.where('first_name = ?', 'Spencer')

p Cohort.find(1)[:name] == 'Best Cohort Ever'
p Cohort.find(10)[:name] == 'Spencers_Team'
p where_cohort

p Student.find(2000)[:first_name] == 'Chaz'
p Student.find(2001)[:first_name] == 'Spencer'
p where_student

jim = Student.create({:cohort_id => 10, :first_name => 'Jim', :last_name => 'Hensen', :email => 'jimhensen@gmail.com', :birthdate => '1950-11-04', :gender => 'm'})
p jim