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
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    volunteer_list = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = volunteer_list.first().fetch("id").to_i
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = volunteer.fetch("name")
    project_id = volunteer.fetch("project_id").to_i
    id = volunteer.fetch("id").to_i
    this_volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => id})
    this_volunteer
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def ==(another_volunteer)
  self.name().==(another_volunteer.name()).&(self.project_id().==(another_volunteer.project_id())).&(self.id().==(another_volunteer.id()))
  end

end
