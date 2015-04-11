module Fastlane
  module Actions
    class NotifyAction < Action
      def self.run(params)
        require 'terminal-notifier'

        text = params.join(' ')
        TerminalNotifier.notify(text, title: 'fastlane')
      end
    end
  end
end
