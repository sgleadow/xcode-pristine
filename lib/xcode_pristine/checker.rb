
module XcodePristine
  class Checker
    def initialize(xcodeproj)
      @project = xcodeproj
    end

    def project_name

    end

    def has_build_settings?
      !message.empty?
    end

    def message
      messages.join("\n")
    end

    def messages
      messages = []

      messages += @project.build_configurations.map { |config| config.build_settings.map { |k,v| "#{config.name}: #{k}=#{v}" } }.flatten
      messages += @project.targets.map { |target| target.build_configurations.map { |config| config.build_settings.map { |k,v| "#{target.name}, #{config.name}: #{k}=#{v}" } }.flatten }.flatten

      messages
    end
  end

end
