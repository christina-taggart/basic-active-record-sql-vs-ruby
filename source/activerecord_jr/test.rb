require_relative 'app'
require 'faker'

def assert(error, test)
  raise error unless test
end


# 1. Instances of Student can be created and saved to the DB
$john_count = Student.where('last_name = ?', "Olmsted").length
john = Student.create :cohort_id => 8,
                      :first_name => "John",
                      :last_name => "Olmsted",
                      :email => "johnaolmsted@gmail.com",
                      :gender => "m"
john.save
assert("Student saves students to db",
        Student.where('last_name = ?', "Olmsted").length == ($john_count += 1))

# 2. Instances of Cohort can be created and saved to the DB
$omega_count = Cohort.where('name = ?', "Omega").length
omega = Cohort.create :name => "Omega"
omega.save
assert("Cohort saves cohorts to db",
        Cohort.where('name = ?', "Omega").length == ($omega_count +=1))

# 3. Student can be searched and updated
test_student = Student.find(50)
new_name = Faker::Name.first_name
test_student[:first_name] = new_name
test_student.save
assert("Student can be searched and updated",
        Student.find(50)[:first_name] == new_name)

# 4. Cohort can be searched and updated
test_cohort = Cohort.find(2)
new_name = Faker::Name.first_name
test_cohort[:name] = new_name
test_cohort.save
assert("Cohort can be searched and updated",
        Cohort.find(2)[:name] == new_name)