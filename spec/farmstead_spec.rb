RSpec.describe Farmstead do
  it "has a version number" do
    expect(Farmstead::VERSION).not_to be nil
  end

  it "has Environment Variables" do
    expect(Farmstead::ENVIRONMENT).not_to be nil
  end

  # it "creates a new project folder" do
  #   args = %w(foo bar)
  #   _, options = Farmstead::CLI.start(args)
  #   expect(options).to eq(true)
  # end
end
