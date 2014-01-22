require_relative 'app'

describe Cohort do
  before do
    cohort = Cohort.find(1)
    cohort[:name] = 'Best Cohort Ever'
    cohort.save
  end
  it "should create a new cohort" do
    expect(Cohort.new.class).to eq(Cohort)
  end
  it "should return correct name" do
    expect(Cohort.find(1)[:name]).to eq('Best Cohort Ever')
  end
end

describe Student do
  before do
    student = Student.find(1)
    student[:first_name] = 'Best Student Ever'
    student.save
  end
  it "should create a new student" do
    expect(Student.new.class).to eq(Student)
  end
  it "should return correct name" do
    expect(Student.find(1)[:first_name]).to eq('Best Student Ever')
  end
end

describe Database::Model do
  it "should create a new model" do
    expect(Database::Model.filename).to eq("/Users/apprentice/Desktop/activerecord-jr-1-a-basic-orm-challenge/source/activerecord_jr/db/students.db")
  end
end