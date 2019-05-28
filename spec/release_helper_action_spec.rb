describe Fastlane::Actions::ReleaseHelperAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The release_helper plugin is working!")

      Fastlane::Actions::ReleaseHelperAction.run(nil)
    end
  end
end
