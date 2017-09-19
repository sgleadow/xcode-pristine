
module XcodePristine
  class Cli
    def initialize args
      @args = args
    end

    def valid?
      @args.size > 0
    end

    def usage
      "Incorrect usage, try something else"
    end

    def project_files
      @args.map { |project_dir| Dir.glob(File.join(project_dir, '*.xcodeproj')) }.flatten
    end
  end
end
