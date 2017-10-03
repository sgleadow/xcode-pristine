require "spec_helper"

RSpec.describe XcodePristine do
  context "when given a directory containing a project" do
    context "without any build settings in the project" do
      it "should run successfully" do
        project_dir = File.join(File.dirname(__FILE__), "examples", "SampleNoSettings")

        expected_output = <<-END_OUTPUT
Project...
Project... OK.
END_OUTPUT

        expect { @result = XcodePristine::Runner.run [project_dir] }.to output(expected_output).to_stdout
        expect(@result).to eq XcodePristine::Status::OK
      end
    end

    context "with build settings in the project" do
      it "should detect and print those build settings" do
        project_dir = File.join(File.dirname(__FILE__), "examples", "SampleWithSettings")

        expected_output = <<-END_OUTPUT
Project...
  Debug: TARGETED_DEVICE_FAMILY=1
  Release: TARGETED_DEVICE_FAMILY=2
  Sample, Debug: IPHONEOS_DEPLOYMENT_TARGET=10.0
  Sample, Release: IPHONEOS_DEPLOYMENT_TARGET=10.0
  SampleTests, Debug: SDKROOT=iphoneos
  SampleTests, Debug: SUPPORTED_PLATFORMS=iphonesimulator iphoneos
  SampleTests, Release: SDKROOT=iphoneos
  SampleTests, Release: SUPPORTED_PLATFORMS=iphonesimulator iphoneos
  SampleUITests, Debug: ENABLE_TESTABILITY=YES
Project... Failed.
END_OUTPUT

        expect { @result = XcodePristine::Runner.run [project_dir] }.to output(expected_output).to_stdout
        expect(@result).to eq XcodePristine::Status::SETTINGS
      end
    end
  end

  context "when given a workspace" do
    context "with build settings in any of the contained projects" do
      it "should detect and print those build settings" do
        project_dir = File.join(File.dirname(__FILE__), "examples", "SampleWorkspace", "Sample.xcworkspace")

        expected_output = <<-END_OUTPUT
Project...
Project... OK.
Project...
  Debug: TARGETED_DEVICE_FAMILY=1
  Release: TARGETED_DEVICE_FAMILY=2
  Sample, Debug: IPHONEOS_DEPLOYMENT_TARGET=10.0
  Sample, Release: IPHONEOS_DEPLOYMENT_TARGET=10.0
  SampleTests, Debug: SDKROOT=iphoneos
  SampleTests, Debug: SUPPORTED_PLATFORMS=iphonesimulator iphoneos
  SampleTests, Release: SDKROOT=iphoneos
  SampleTests, Release: SUPPORTED_PLATFORMS=iphonesimulator iphoneos
  SampleUITests, Debug: ENABLE_TESTABILITY=YES
Project... Failed.
END_OUTPUT

        expect { @result = XcodePristine::Runner.run [project_dir] }.to output(expected_output).to_stdout
        expect(@result).to eq XcodePristine::Status::SETTINGS
      end
    end
  end

  context "with invalid arguments" do
    before(:example) do
      @usage_output = <<-END_OUTPUT
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

    context "because the directory does not contain a project" do
      it "should detect the usage error" do
        project_dir = File.join(File.dirname(__FILE__), "examples")

        expect { @result = XcodePristine::Runner.run [project_dir] }.to output(@usage_output).to_stdout
        expect(@result).to eq XcodePristine::Status::USAGE
      end
    end

    context "because no arguments are given" do
      it "should detect the usage error" do
        project_dir = File.join(File.dirname(__FILE__), "examples")

        expect { @result = XcodePristine::Runner.run [] }.to output(@usage_output).to_stdout
        expect(@result).to eq XcodePristine::Status::USAGE
      end
    end
  end
end
