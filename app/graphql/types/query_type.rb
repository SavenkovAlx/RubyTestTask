# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :github, GithubType, 'Find a username and repos by login' do
      argument :login, String, required: true
    end

    def github(login:)
      client = Octokit::Client.new \
        client_id: ENV.fetch('CLIENT_ID', nil),
        client_secret: ENV.fetch('CLIENT_SECRET', nil)

      user = client.user login

      repos = client.repos(user.login, query: { sort: 'asc' })
      repos.each_with_index { |rep, index| repos[index] = rep.name }

      { 'username' => user.name,
        'repos' => repos }
    end
  end
end
