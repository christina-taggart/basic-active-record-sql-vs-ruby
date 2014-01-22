require_relative 'app'
require 'faker'


def assert(error, test)
  raise error unless test
end


# 1. Instances of Student can be created and saved to the DB
$nic_count = Student.where('last_name = ?', "Cu").length
nic = Student.create :cohort_id => 8,
                      :first_name => "Nic",
                      :last_name => "Cu",
                      :email => "nicholascu@gmail.com",
                      :gender => "m"
nic.save
assert("Student saves students to db",
        Student.where('last_name = ?', "Cu").length == ($nic_count += 1))

# $nic_count = Student.where("first_name = ?", "Nic").length
# nic = Student.create


# 2. Instances of Cohort can be created and saved to the DB
$sigma_count = Cohort.where('name = ?', "Sigma").length
sigma = Cohort.create :name => "Sigma"
sigma.save
assert("Cohort saves cohorts to db",
        Cohort.where('name = ?', "Sigma").length == ($sigma_count +=1))


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