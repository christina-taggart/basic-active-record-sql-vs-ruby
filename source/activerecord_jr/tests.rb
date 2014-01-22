require_relative 'app'

claude = Student.where('first_name = ?', 'Claude').first

p claude[:gender] == "f"
p claude[:id] == 1804

claude[:last_name] = "Hey"
claude.save

new_claude = Student.where('id = ?', 1804).first
p new_claude[:last_name] == "Hey"

