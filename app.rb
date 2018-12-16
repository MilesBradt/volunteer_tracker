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
  erb(:project)
end

post("/edit/:id") do
  id = params[:id]
  edit = params.fetch("edit")
  @project = Project.find(id)
  @project.update({:title => edit, :id => id})
  erb(:project)
end
