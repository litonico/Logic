task :test do
  Dir["test/*.rb"].each do |testfile|
    system "ruby -Isrc #{testfile}"
  end
end
