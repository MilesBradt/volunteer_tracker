require 'pg'
require 'pry'

class Project
  attr_reader(:title, :id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    list = DB.exec("SELECT * FROM projects;")
    projects = []
    list.each() do |volunteer|
      title = volunteer.fetch("title")
      id = volunteer.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def save
    project_list = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = project_list.first().fetch("id").to_i

  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    this_project = Project.new({:title => title , :id => id})
    this_project
  end

  def volunteers
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

  def ==(another_volunteer)
  self.title().==(another_volunteer.title()).&(self.id().==(another_volunteer.id()))
  end

end
