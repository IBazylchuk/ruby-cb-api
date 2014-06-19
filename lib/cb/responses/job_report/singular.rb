module Cb
  module Responses
    module JobReport
  	  class Singular < ApiResponse

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(model_node, response[root_node])
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          Models::JobReport.new(model_hash)
        end

        private

        def root_node
          'ResponseJobReport'
        end

        def model_node
          'Buckets'
        end

        def model_hash
          response[root_node]
        end
      end
  	end
  end
end
