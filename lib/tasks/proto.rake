namespace :proto do
  desc "Regenerate all protos"
  task(:all) {}

  ROOT = File.expand_path("../../..", __FILE__)

  PROTO_REGISTRY = {
    directory: File.join(ROOT, "app", "protos").freeze,
    output: File.join(ROOT, "lib").freeze,
  }.freeze

  Dir["#{PROTO_REGISTRY[:directory]}/*.proto"].each do |file|
    proto = File.basename(file, ".proto")
    desc "Regenerate #{proto} proto"
    task proto do
      command = [
        "bundle", "exec", "grpc_tools_ruby_protoc",
        "-I", PROTO_REGISTRY[:directory],
        "--ruby_out=#{PROTO_REGISTRY[:output]}",
        "--grpc_out=#{PROTO_REGISTRY[:output]}",
        file
      ]
      system(
        *command
      ) or raise "Could not execute grpc_tools_ruby_protoc"
    end
    task all: proto
  end
end
