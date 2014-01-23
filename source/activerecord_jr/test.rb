require_relative 'app'

p Cohort.find(1)[:name]
p Cohort.find(1)[:name] == 'Best Cohort Ever'
p Cohort.where('name = ?', 'Epsilon')[0].attributes[:id] == 5
p Cohort.find(4).attributes[:name] == 'Gamma'

p Student.find(1)[:first_name] == 'Ryley'
p Student.where('first_name = ?', 'Ryley')[0].attributes[:id] == 1
stu = {first_name: 'Stuart3', last_name: 'McThreerson',
                  email: 'abc@mail.com', birthdate: Time.now,
                  cohort_id: 6, gender: 'm'}

Student.create(stu)


# # Challenge #2


# # puts Cohort.all
# puts Database::Model.all(Cohort)


# # puts Student.all
# puts Database::Model.all(Student)


# # create new cohort
# attributes = {name: 'sea-lions'}

# Cohort.create(attributes)
# puts Database::Model.all(Cohort)[-1]
# puts Database::Cohort.all

# # create new student
# # puts Database::Model.all(Student)[-1]
