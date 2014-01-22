require_relative 'app.rb'

# def assert(method_call, expected, actual)
#   actual = method_call
#   if actual == expected
#     puts "true"
#   else 
#     puts "You expected #{expected} but got #{actual}."
#   end
# end


cohort = Cohort.find(1)
cohort[:name] = 'Best Cohort Ever'
cohort.save

# This re-queries the database, so we're checking that we actually
# saved the data as intended
p Cohort.find(1)[:name] == 'Best Cohort Ever'

cohort[:name] = 'Second Best Cohort Ever'
cohort.save

# requery the db again!
p Cohort.find(1)[:name] == 'Second Best Cohort Ever'

#find a student and change the student's name
student = Student.find(5)
student[:first_name] = 'Martha'
student.save

# check to see if the save worked
p Student.find(5)[:first_name] == 'Martha'

#create a new student
new_student = Student.new(
        :cohort_id => 5,
        :first_name => 'Test',
        :last_name => 'Person',
        :email => 'test@person.com',
        :gender => 'male',
        :birthdate => '1990-12-12'
  )

# this should be a new student, i.e. he doesn't have an id yet (determined when seeding the database)
p new_student.new_record? == true
new_student.save

# after saving a student, they are added to the database
p new_student.new_record? == false
p Student.find(2001)[:first_name] == "Test"


# change a cohort name

second_cohort = Cohort.find(5)
second_cohort[:name] = "Not epsilon"
second_cohort.save

p Cohort.find(5)[:name] == "Not epsilon"
