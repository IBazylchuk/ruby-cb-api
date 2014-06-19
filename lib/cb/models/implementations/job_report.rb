module Cb
  module Models
    class JobReport < ApiResponseModel
      attr_accessor :did, :total_apps, :buckets,
                    :education_major, :years_expirience, :education_degrees, :company_name, :school_name

      def initialize(args = {})
        super(args)
      end

      protected

      def required_fields
        []
      end

      def set_model_properties
        args = api_response

        # General
        @did                          = args['JobDID'] || ''
        @total_apps                   = (args['TotalApps'] || 0).to_i
        @buckets                      = args['Buckets'] || {}

        (@buckets['Bucket'] || []).each do |item|
          case item["@Type"]
          when 'EducationMajor'
            @education_major = parse_item(item['Item'])
          when 'YearsExperience'
            @years_expirience = parse_item(item['Item'])
          when 'EducationDegrees'
            @education_degrees = parse_item(item['Item'])
          when 'CompanyName'
            @company_name = parse_item(item['Item'])
          when 'SchoolName'
            @school_name = parse_item(item['Item'])
          else
            raise 'Unknown Bucket'
          end
        end
      end

      private

      def parse_item(item)
        item.map do |i|
          { 
            key: i['Key'] || '',
            count: (i['Count'] || 0).to_i
          }
        end
      end

    end
  end
end
