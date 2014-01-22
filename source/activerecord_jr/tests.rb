require_relative 'app.rb'
require 'sqlite3'
db = SQLite3::Database.new('db/students.db')

db.execute('DELETE FROM cohorts WHERE id > 9;')
db.execute('DELETE FROM students WHERE id > 2000;')

cohort = Cohort.find(1)
cohort[:name] = 'Best Cohort Ever'
cohort.save
p Cohort.find(1)[:name] == 'Best Cohort Ever'

ramons = Student.where('first_name=?', 'Ramon')

ramons.first[:email] = 'Ramonramon@ramon.com'
ramons.first.save
p ramons.first[:email] == 'Ramonramon@ramon.com'

new_student = {:first_name => 'Madeinusa', :last_name => 'Funfact',
                   :email => 'Funmade@yahoo.com', :gender => 'f', :birthdate => '1989-06-27', :created_at => Time.now, :updated_at => Time.now}

Student.create(new_student)
madeinusa = Student.find(2001)


new_student2 = {:first_name => 'Edileusa', :last_name => 'Funfact',
                   :email => 'Funmade@yahoo.com', :gender => 'f', :birthdate => '1989-06-27', :created_at => Time.now, :updated_at => Time.now}
Student.create(new_student2)




Student.create({:first_name => 'Medusa', :gender => 'f', :created_at => Time.now, :updated_at => Time.now})
medusa = Student.where('first_name=?', 'Medusa').first
p medusa[:first_name] == 'Medusa'
p medusa[:last_name] == nil

Cohort.create(:name => 'Sea Lions', :created_at => Time.now, :updated_at => Time.now)
sea_lions = Cohort.where('name=?', 'Sea Lions').first
p sea_lions[:name] == 'Sea Lions'

