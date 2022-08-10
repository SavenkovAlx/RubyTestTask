require 'rails_helper'

RSpec.describe 'Github API', type: :request do

  it 'returns username and repos' do
    query_string = <<-GRAPHQL
  query github($login: String!) {
    github(login: $login) {
      username
      repos
    }
  }
    GRAPHQL

    variables = { "login" => "svnalx"}

    result = CyberTaskSchema.execute(query_string, variables: variables)


    expect(result.dig("data", "github", "username")).to eq("Alex Crist")
    expect(result.dig("data", "github", "repos")).to eq(["web3_examples",
                                                         "unit-testing-angular-with-jest-tutorial",
                                                          "sitemarks",
                                                          "dev-demos",
                                                          "svnalx.github.io",
                                                          "alex-crist",
                                                          "bookshelf-react-express-sqlite-app",
                                                          "angular-cli",
                                                          "alex-crist.com"
                                                        ])

  end
end