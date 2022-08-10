require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.default_cassette_options = {
    decode_compressed_response: true
  }
  c.cassette_library_dir = 'vcr/cassettes'
  c.allow_http_connections_when_no_cassette = true
end

