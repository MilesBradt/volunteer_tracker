require 'pg'
require 'pry'

class Volunteer
  attr_reader(:name, :id)

  def inializer(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    list = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    list.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :id => id}))
    end
    volunteers
  end


end
