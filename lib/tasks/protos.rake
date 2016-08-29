namespace :protos do
  directory "app/protos"

  desc "Copies the protos from the embedded API server"
  task :copy => "app/protos" do
    sh "cp -v api/lib/*_pb.rb lib/"
    sh "cp -v api/protos/*.proto app/protos"
  end
end
