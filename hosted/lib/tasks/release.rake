namespace :release do
  task postbuild: [:environment, :'db:migrate'] do
    ClientBuilder.new.populate
  end
end
