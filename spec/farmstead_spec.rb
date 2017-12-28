RSpec.describe Farmstead do
  it "has a version number" do
    expect(Farmstead::VERSION).not_to be nil
  end

  # it "sets options to the next method to be invoked" do
  #   args = %w(foo bar)
  #   _, options = Farmstead::CLI.start(args)
  #   expect(options).to eq(true)
  # end
end
