module Arroyo
  class SimpleUploader
    attr_reader :session, :upload
    delegate :key, :source, to: :upload

    def initialize(session:, upload:)
      @session = session
      @upload  = upload
    end

    def call
      session.put(key, body: source).then do |response|
        response.status.ok? || raise(Error, "Unexpected response status")
      end
    end
  end
end
