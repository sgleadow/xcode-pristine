
module XcodePristine
  class ProjectFinder
    def initialize args
      @project_files = args.map { |project_dir| Dir.glob(File.join(project_dir, '*.xcodeproj')) }.flatten
    end

    def project_files
      @project_files
    end

    def valid?
      project_files.size > 0
    end
  end
end
