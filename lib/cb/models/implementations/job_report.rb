module Cb
  module Models
    class JobReport < ApiResponseModel
      attr_accessor :did, :total_apps, :buckets,
                    :education_major, :years_experience, :education_degrees, :company_name, :school_name

      AVAILABLE_FIELDS = [
        :did, 
        :total_apps,
        :education_major, 
        :years_experience, 
        :education_degrees, 
        :company_name, 
        :school_name        
      ]

      KEYS = {
        education_major: 'EducationMajor',
        years_experience: 'YearsExperience',
        education_degrees: 'EducationDegrees',
        company_name: 'CompanyName',
        school_name: 'SchoolName'
      }

      EDUCATION_DEGREES_KEYS = {
        '0' => "Bachelor's",
        '1' => 'High School',
        '2' => 'Associate',
        '3' => "Master's",
        '4' => 'Doctorate'
      }

      YEARS_EXPERIENSE_KEYS = {
        '0' => '&lt; 2',
        '1' => '2 - 4',
        '2' => '5 - 9',
        '3' => '10 - 14',
        '4' => '15 - 19',
        '5' => '20+',
      }

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
          key = key = KEYS.find { |key,value| value == item['@Type'] }
          if key
            instance_variable_set(("@#{key[0]}"), parse_item(item['Item']))
          else
            raise "Unknown Bucket: #{item['@Type']} for id: #{@did}"
          end
        end

        parse_years_experience
        parse_education_degrees
      end

      private

      def parse_years_experience
        @years_experience = parse_static(@years_experience, YEARS_EXPERIENSE_KEYS)
      end

      def parse_education_degrees
        @education_degrees = parse_static(@education_degrees, EDUCATION_DEGREES_KEYS)
      end

      def parse_static(variable, keys)
        _variable = {}
        variable.each do |variable_key, variable_value|
          _key, _value = keys.find { |key,value| value == variable_key }
          _variable[_key.present? ? _key : variable_key] = variable_value
        end
        _variable
      end

      def parse_item(item)
        hash = {}
        item.each do |i|
          key = i['Key'] || ''
          hash[key] = (i['Count'] || 0).to_i
        end
        hash
      end
    end
  end
end
