class Cohort < Database::Model

  # CLASS METHODS

  def self.all
    Database::Model.execute("SELECT * FROM cohorts").map do |row|
      Cohort.new(row)
    end
  end

  def self.create(attributes)
    record = self.new(attributes)
    record.save

    record
  end

  def self.where(query, *args)
    Database::Model.execute("SELECT * FROM cohorts WHERE #{query}", *args).map do |row|
      Cohort.new(row)
    end
  end

  def self.find(pk)
    self.where('id = ?', pk).first
  end

  # INSTANCE METHODS

  self.attribute_names =  [:id, :name, :created_at, :updated_at]

  attr_reader :attributes, :old_attributes

  def table_name
    "cohorts"
  end

  def students
    Student.where('cohort_id = ?', self[:id])
  end

  def add_students(students)
    students.each do |student|
      student.cohort = self
    end

    students
  end

  def new_record?
    self[:id].nil?
  end
end
