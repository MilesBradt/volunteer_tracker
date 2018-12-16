require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")


DB = PG.connect({:dbname => "volunteer_tracker_test"})

get("/") do
  @projects = Project.all
  erb(:index)
end


post("/") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  erb(:index)
end

get("/:id") do
  id = params[:id]
  @project = Project.find(id)
  @project_volunteers = @project.volunteers
  erb(:project)
end

post("/add/:id") do
  project_id = params[:id]
  @project = Project.find(project_id)
  name = params.fetch("add")
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save
  @project_volunteers = @project.volunteers
  erb(:project)
end

post("/edit/:id") do
  id = params[:id]
  edit = params.fetch("edit")
  @project = Project.find(id)
  @project_volunteers = @project.volunteers
  @project.update({:title => edit, :id => id})
  erb(:project)
end

post("/edit_volunteer/:id") do
  id = params[:id]
  edit = params.fetch("edit_volunteer")
  @volunteer = Volunteer.find(id)
  @volunteer.update({:name => edit, :id => id})
  erb(:volunteer)
end


get("/delete/:id") do
  id = params[:id]
  @project = Project.find(id)
  @project.delete
  redirect("/")
end

get("/volunteer/:id") do
  id = params[:id]
  @volunteer = Volunteer.find(id)
  erb(:volunteer)
end
