require 'xcodeproj'

module XcodePristine
  class ProjectFinder
    attr_reader :projects

    def initialize args
      @projects = args.map do |path|
        workspaces = Dir.glob(File.join(path, '*.xcworkspace'))
        projects = Dir.glob(File.join(path, '*.xcodeproj'))

        if path.end_with? "xcworkspace"
          projects_from_workspace path
        elsif path.end_with? "xcodeproj"
          project_from_file path
        elsif workspaces.empty?
          projects_from_files(projects)
        else
          projects_from_workspace_files(workspaces)
        end
      end.flatten
    end

    def project_from_file project_file
      Xcodeproj::Project.open(project_file)
    end

    def projects_from_files files
      files.map do |project_file|
        project_from_file(project_file)
      end
    end

    def projects_from_workspace workspace_file
      workspace = Xcodeproj::Workspace.new_from_xcworkspace(workspace_file)
      workspace.file_references.select do |file_reference|
        file_reference.path.end_with? 'xcodeproj'
      end.map do |project_file_reference|
        project_file = File.join(workspace_file, '..', project_file_reference.path)
        project_from_file(project_file)
      end
    end

    def projects_from_workspace_files workspaces
      workspaces.map do |workspace_file|
        projects_from_workspace(workspace_file)
      end.flatten
    end
  end
end
