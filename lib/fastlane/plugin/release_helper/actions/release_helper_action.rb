require 'fastlane/action'
require_relative '../helper/release_helper_helper'

module Fastlane
  module Actions
    class ReleaseHelperAction < Action
      def self.get_last_tag(params)
        command = "git describe --tags --match=#{params[:match]}"
        Actions.sh(command, log: false)
      end

      def self.get_commits_from_hash(params) 
        commits = Helper::ReleaseHelperHelper.git_log('%s|%b', params[:hash])
        commits.split("\n")
      end
      
      def self.run(params)
        hash = "HEAD"
        version = "0.0.0"

        tag = get_last_tag(match: params[:match])

        if tag.empty?
          UI.message("First commit of the branch is taken as a begining of next release")
          # If there is no tag found we taking the first commit of current branch
          hash = Actions.sh('git rev-list --max-parents=0 HEAD', log: false).chomp
        else
          # Tag's format is v2.3.4-5-g7685948
          # See git describe man page for more info
          tag_name = tag.split('-')[0].strip
          parsed_version = tag_name.match(params[:tag_version_match])

          if parsed_version.nil?
            UI.user_error("Error while parsing version from tag")
          end

          version = parsed_version[0]
          UI.message(version)
        end
      end

      def self.description
        "release heper"
      end

      def self.authors
        ["Artem Ivanov"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Release helper"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "RELEASE_HELPER_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
