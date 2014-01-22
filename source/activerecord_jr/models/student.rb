class Student < Database::Model

  # CLASS METHODS

  def self.all
    Database::Model.execute("SELECT * FROM students").map do |row|
      Student.new(row)
    end
  end

  def self.create(attributes)
    record = self.new(attributes)
    record.save
    record
  end

  def self.where(query, *args)
    Database::Model.execute("SELECT * FROM students WHERE #{query}", *args).map do |row|
      Student.new(row)
    end
  end

  def self.find(pk)
    self.where('id = ?', pk).first
  end

  # INSTANCE METHODS

  self.attribute_names =  [:id, :cohort_id, :first_name, :last_name, :email,
                           :gender, :birthdate, :created_at, :updated_at]

  attr_reader :attributes, :old_attributes

  def table_name
    "students"
  end

  # We say a record is "new" if it doesn't have a defined primary key in its
  # attributes
  def new_record?
    self[:id].nil?
  end

  def cohort
    Cohort.where('id = ?', self[:cohort_id]).first
  end

  def cohort=(cohort)
    self[:cohort_id] = cohort[:id]
    self.save
    cohort
  end
end
