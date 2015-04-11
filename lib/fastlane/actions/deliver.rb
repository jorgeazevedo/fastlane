module Fastlane
  module Actions
    module SharedValues
    end

    class DeliverAction < Action
      def self.run(params)
        require 'deliver'

        FastlaneCore::UpdateChecker.start_looking_for_update('deliver')

        ENV['DELIVER_SCREENSHOTS_PATH'] = Actions.lane_context[SharedValues::SNAPSHOT_SCREENSHOTS_PATH]

        force = params.include?(:force)
        beta = params.include?(:beta)
        skip_deploy = params.include?(:skip_deploy)

        Dir.chdir(FastlaneFolder.path || Dir.pwd) do
          # This should be executed in the fastlane folder
          Deliver::Deliverer.new(nil,
                                 force: force,
                                 is_beta_ipa: beta,
                                 skip_deploy: skip_deploy)

          Actions.lane_context[SharedValues::IPA_OUTPUT_PATH] = File.expand_path(ENV['DELIVER_IPA_PATH']) # deliver will store it in the environment
        end

        FastlaneCore::UpdateChecker.show_update_status('deliver', Deliver::VERSION)
      end
    end
  end
end
