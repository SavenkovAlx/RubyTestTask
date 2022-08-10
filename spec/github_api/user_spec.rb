require 'rails_helper'

RSpec.describe Octokit::Client::Users do
  let(:test_user) { Octokit::Client.new \
        client_id: ENV.fetch('CLIENT_ID', 'fake'),
        client_secret: ENV.fetch('CLIENT_SECRET', 'fake') }
  let(:user_login) { 'svnalx' }

  specify "#user" do
    user = VCR.use_cassette('users/user') do
      test_user.user user_login
    end
    expect(user['login']).to eq (user_login)
    expect(user['name']).to eq ('Alex Crist')
    expect(user['url']).to eq ('https://api.github.com/users/svnalx')
  end
end