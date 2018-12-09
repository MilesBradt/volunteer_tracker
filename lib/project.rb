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
    volunteer_list = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = volunteer_list.first().fetch("id").to_i
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = volunteer.fetch("title")
    id = volunteer.fetch("id").to_i
    this_volunteer = Project.new({:title => title , :id => id})
    this_volunteer
  end

  def ==(another_volunteer)
  self.title().==(another_volunteer.title()).&(self.id().==(another_volunteer.id()))
  end

end
