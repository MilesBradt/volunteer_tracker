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

get("/:title") do
  
end
