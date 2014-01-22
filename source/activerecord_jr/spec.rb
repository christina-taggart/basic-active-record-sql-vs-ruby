require_relative 'app.rb'

describe Cohort do
  it "has Alpha as the first cohort name" do
    Cohort.find(1)[:name].should eql "Alpha"
  end

  it "has Iota as the last cohort name" do
    Cohort.find(9)[:name].should eql "Iota"
  end

  it "the where method returns the right cohort" do
    Cohort.where('name = ?', 'Alpha')[0][:name].should eql "Alpha"
  end

  it "able to initialize" do
    Cohort.new.should be_an_instance_of Cohort
  end
end

describe Student do
  it "able to count 2000 students with the #all method" do
    Student.all.count.should eql 2000
  end

  it "able to select a specific student with the #where method" do
    Student.where('first_name = ?', 'Corine')[0].should be_an_instance_of Student
  end

  it "able to select a student by id" do
    Student.find(13).should be_an_instance_of Student
  end

  it "able to initialize" do
    Student.new.should be_an_instance_of Student
  end
end



