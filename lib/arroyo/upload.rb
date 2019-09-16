require "arroyo/uploaders"

module Arroyo
  class Upload
    attr_reader :session, :key, :source
    delegate :size, to: :source

    def initialize(session:, key:, source:)
      @session = session
      @key     = key
      @source  = source
    end

    def perform
      uploader.call
    end

    private
      def uploader
        if size < 10.megabytes
          SimpleUploader.new self
        else
          MultipartUploader.new self
        end
      end
  end
end
