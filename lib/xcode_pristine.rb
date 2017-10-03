require 'xcodeproj'

require "xcode_pristine/version"
require "xcode_pristine/checker"
require "xcode_pristine/project_finder"

module XcodePristine
  class Runner
    def self.run args
      finder = ProjectFinder.new args

      projects = finder.projects.map do |xcodeproj|
        Checker.new(xcodeproj)
      end

      if projects.empty?
        puts USAGE_MESSAGE
        return Status::USAGE
      end

      projects.each do |checker|
        puts "Project..."

        if checker.has_build_settings?
          indent = "  "
          puts checker.message indent
          puts "Project... Failed."
        else
          puts "Project... OK."
        end
      end

      if projects.any? { |checker| checker.has_build_settings? }
        return Status::SETTINGS
      else
        return Status::OK
      end
    end

    USAGE_MESSAGE = <<-END_OUTPUT
Error: could not find any projects or workspaces to check from the arguments passed to xcpristine.

Usage:
  xcpristine <path 1> <path 2> ... <path N>

Where each path can be one of:

  an Xcode project
    the path to a .xcodeproj, eg. ./path/to/Example.xcodeproj
    (checks that project for build settings)

  an Xcode workspace
    the path to a .xcworkspace, eg. ./path/to/Example.xcworkspace
    (checks each top level Xcode project file in the workspace for build settings)

  a directory
    the path to a directory containing .xcodeproj or .xcworkspace files
    (if found, checks the workspace, otherwise, checks the project)
END_OUTPUT
  end

  class Status
    OK = 0
    USAGE = 1
    SETTINGS = 2
  end
end
