require 'rails_helper'

RSpec.describe Octokit::Client::Repositories do
  let(:test_user) { Octokit::Client.new \
        client_id: ENV.fetch('CLIENT_ID', 'fake'),
        client_secret: ENV.fetch('CLIENT_SECRET', 'fake') }
  let(:user_login) { 'svnalx' }

  specify '#repositories' do
    repos = VCR.use_cassette('repos/repos') do
      test_user.repos(user_login)
    end
    expect(repos[0]['id']).to eq (363302041)
    expect(repos[1]['id']).to eq (194480954)
    expect(repos[2]['id']).to eq (254725188)
  end
end