# frozen_string_literal: true

module Types
  class GithubType < Types::BaseObject
    field :username, String, null: false
    field :repos, [String], null: false
  end
end
