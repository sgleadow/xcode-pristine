require "spec_helper"

RSpec.describe XcodePristine::Checker do
  context "when there are no configurations or targets" do
    before(:example) do
      empty_project = double("empty_project", :build_configurations => [], :targets => [])
      @checker = XcodePristine::Checker.new empty_project
    end

    it "should verify there are no build settings" do
      expect(@checker.has_build_settings?).to be false
    end

    it "should have no message" do
      expect(@checker.message).to be_empty
    end
  end

  context "when the configurations have empty settings" do
    before(:example) do
      empty_config = double("empty_config", :name => "Sample Config", :build_settings => {})
      project_empty_config = double("project_empty_config", :build_configurations => [empty_config], :targets => [])
      @checker = XcodePristine::Checker.new project_empty_config
    end

    it "should verify there are no build settings" do
      expect(@checker.has_build_settings?).to be false
    end
  end

  context "when a configuration contains build settings" do
    before(:example) do
      non_empty_config = double("non_empty_config", :name => "Sample Config", :build_settings => {"SOME_SETTING" => "some_value"})
      project_non_empty_config = double("project_non_empty_config", :build_configurations => [non_empty_config], :targets => [])
      @checker = XcodePristine::Checker.new project_non_empty_config
    end

    it "should detect the build settings" do
      expect(@checker.has_build_settings?).to be true
    end

    it "should report the settings in the message" do
      message = @checker.message
      expect(message).not_to be_empty
    end
  end

  context "when the targets have empty settings" do
    before(:example) do
      empty_config = double("empty_config", :name => "Sample Config", :build_settings => {})
      empty_target = double("empty_target", :name => "Sample Target", :build_configurations => [empty_config])
      project_empty_target = double("project_empty_target", :build_configurations => [], :targets => [empty_target])
      @checker = XcodePristine::Checker.new project_empty_target
    end

    it "should verify there are no build settings" do
      expect(@checker.has_build_settings?).to be false
    end
  end

  context "when the target contains build settings" do
    before(:example) do
      non_empty_config = double("non_empty_config", :name => "Sample Config", :build_settings => {"SOME_SETTING" => "some_value"})
      non_empty_target = double("non_empty_target", :name => "Sample Target", :build_configurations => [non_empty_config])
      project_empty_target = double("project_empty_target", :build_configurations => [], :targets => [non_empty_target])
      @checker = XcodePristine::Checker.new project_empty_target
    end

    it "should detect the build settings" do
      expect(@checker.has_build_settings?).to be true
    end

    it "should report the settings in the message" do
      message = @checker.message
      expect(message).not_to be_empty
    end
  end
end
