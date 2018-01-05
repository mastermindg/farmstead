# Test subcommands

module Farmstead
  module CLI
    class Test < Thor
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
end
