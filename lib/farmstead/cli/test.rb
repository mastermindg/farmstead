# Test subcommands

module Farmstead
  class CLITest < Thor
    desc "foo", "Test foo"
    def foo
      true
    end

    desc "bar", "Test bar"
    def bar
      true
    end
  end
end
