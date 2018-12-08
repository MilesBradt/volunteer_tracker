require 'pg'
require 'pry'

class Volunteer
  attr_reader(:name, :project_id, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
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

  def ==(another_volunteer)
  self.name().==(another_volunteer.name()).&(self.project_id().==(another_volunteer.project_id())).&(self.id().==(another_volunteer.id()))
  end

end
