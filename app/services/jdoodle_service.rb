# app/services/jdoodle_service.rb
class JDoodleService
  include HTTParty
  base_uri JDoodleAPI::BASE_URL

  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
  end

  def compile_and_execute(code, language)
    response = self.class.post(
      '',
      body: {
        clientId: @client_id,
        clientSecret: @client_secret,
        script: code,
        language: language,
        versionIndex: '0'
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    handle_response(response)
  end

  private

  def handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      # Handle error cases
      raise "JDoodle Error: #{response.body}"
    end
  end
end

