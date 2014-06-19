require 'json'

module Cb
  module Clients
    class JobReport
      class << self

        def find_by_did(did)
          json_response = api_client.cb_get(Cb.configuration.uri_job_report, query: { JobDID: did })
          Responses::JobReport::Singular.new(json_response)
        end

        private

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

      end
    end
  end
end
