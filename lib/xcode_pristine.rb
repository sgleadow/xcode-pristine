require 'xcodeproj'

require "xcode_pristine/version"
require "xcode_pristine/checker"
require "xcode_pristine/cli"
require "xcode_pristine/project_finder"

module XcodePristine
  class Runner
    def self.run args
      cli = Cli.new args

      unless cli.valid?
        puts cli.usage
        exit 1
      end

      projects = cli.project_files.map do |proj|
        Xcodeproj::Project.open(proj)
      end.map do |xcodeproj|
        XcodePristine::Checker.new(xcodeproj)
      end

      projects.each do |checker|
        puts "*************"
        puts checker.message
      end

    end
  end
end
