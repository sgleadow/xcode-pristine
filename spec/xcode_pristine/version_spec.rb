require "spec_helper"

RSpec.describe "XcodePristine::Version" do
  it "has a version number" do
    expect(XcodePristine::Version::CURRENT).not_to be nil
  end
end
