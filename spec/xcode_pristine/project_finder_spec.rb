require "spec_helper"

RSpec.describe XcodePristine::ProjectFinder do
  context "when there are no arguments" do
    before(:example) do
      @finder = XcodePristine::ProjectFinder.new []
    end

    it "should have an empty list of project" do
      expect(@finder.projects).to be_empty
    end
  end

  context "when given a single directory" do
    context "with no projects or workspaces" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "NoProjectsOrWorkspaces")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should have an empty list of projects" do
        expect(@finder.projects).to be_empty
      end
    end

    context "containing a project" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "SampleWithSettings")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should find the project file" do
        expect(@finder.projects.size).to eq 1
      end
    end

    context "containing a workspace" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "SampleWorkspace")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should find each project in the workspace" do
        expect(@finder.projects.size).to eq 2
      end
    end

    context "containing a workspace and a project" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "WorkspaceOverProject")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should find each project in the workspace in preference to the project in the directory" do
        expect(@finder.projects.size).to eq 2
      end
    end
  end

  context "when given a project file" do
    before(:example) do
      path = File.join(File.dirname(__FILE__), "..", "examples", "SampleWithSettings", "SampleWithSettings.xcodeproj")
      @finder = XcodePristine::ProjectFinder.new [path]
    end

    it "should load that project file" do
      expect(@finder.projects.size).to eq 1
    end
  end

  context "when given a workspace file" do
    context "containing no project" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "EmptyWorkspace", "Empty.xcworkspace")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should have an empty list of projects" do
        expect(@finder.projects).to be_empty
      end
    end

    context "containing multiple projects" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "SampleWorkspace", "Sample.xcworkspace")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should load the projects from that workspace" do
        expect(@finder.projects.size).to eq 2
      end
    end

    context "containing a workspace and a project" do
      before(:example) do
        path = File.join(File.dirname(__FILE__), "..", "examples", "WorkspaceOverProject", "Sample.xcworkspace")
        @finder = XcodePristine::ProjectFinder.new [path]
      end

      it "should find each project in the workspace in preference to the project in the directory" do
        expect(@finder.projects.size).to eq 2
      end
    end
  end

  context "when given multiple directories" do
    before(:example) do
      path1 = File.join(File.dirname(__FILE__), "..", "examples", "SampleWithSettings")
      path2 = File.join(File.dirname(__FILE__), "..", "examples", "SampleNoSettings")
      @finder = XcodePristine::ProjectFinder.new [path1, path2]
    end

    it "should find the projects in all directories" do
      expect(@finder.projects.size).to eq 2
    end
  end
end
