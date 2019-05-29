require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class ReleaseHelperHelper
      # class methods that you define here become available in your action
      # as `Helper::ReleaseHelperHelper.your_method`

      def self.git_log(pretty, start)
        UI.message("git log is OK")
        command = "git log --pretty='#{pretty}' --reverse #{start}..HEAD"
        Actions.sh(command, log: false).chomp
      end

      def self.parse_commit(params) 
        UI.message(params)
      end

      def self.show_message
        UI.message("Hello from the release_helper plugin helper!")
      end
    end
  end
end
