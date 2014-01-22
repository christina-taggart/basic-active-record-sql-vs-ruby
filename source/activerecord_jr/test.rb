require_relative 'app'

test_cohort = Cohort.where('name = ?', 'Delta').first
# puts test_cohort.students[5]
previous_student_count = test_cohort.students.count

pancake = [Student.new(:first_name => 'Peter', :last_name => 'Penguin', :email => 'awesome@possum.net', :gender => 'm', :birthdate => DateTime.now, :created_at => DateTime.now, :updated_at => DateTime.now)]
test_cohort.add_students(pancake)


# Test codes
puts test_cohort[:name] == 'Delta'
puts test_cohort.students.count == previous_student_count+1
puts test_cohort.students.last[:first_name] == 'Peter'



