require_relative 'app'

cohort = Cohort.find(1)
cohort[:name] = 'Danger Zone'
p Cohort.find(1)[:name] == 'Danger Zone'


deshaun = Student.find(1)
deshaun[:gender] = 'm'
deshaun.save
p Student.find(1)[:gender] == 'm'

darcey = Student.create({:first_name => 'Darcey', :last_name => 'Lachtman', :email => 'dslachtman@Gmail.com', :gender => 'f', :birthdate => '1991-01-16'})
darcey[:cohort_id] = 1
p darcey.cohort[:name] == "Danger Zone"

