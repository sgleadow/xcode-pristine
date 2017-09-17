
module XcodePristine
  class Checker
    def initialize(xcodeproj)
      @project = xcodeproj
    end

    def has_build_settings?
      !message.empty?
    end

    def message
      messages.join("\n")
    end

    private

    def messages
      messages = []

      messages += message_for_configurations(@project.build_configurations)
      messages += message_for_configurations(@project.targets.map(&:build_configurations).flatten)

      messages
    end

    def message_for_configurations configurations
      configurations.map { |config| config.build_settings.map { |k,v| "#{k}=#{v}" } }.flatten
    end
  end

end
