require 'spec_helper'

module Cb::Criteria::Application
  describe Create do

    describe '#to_json' do
      context 'when creating real resources' do
        it 'converts the criteria to json' do
          expect(criteria.to_json).to eq(expected_json)
        end
      end

      context 'when test_resources is enabled' do
        before { Cb.configuration.test_resources = true }
        it 'converts the criteria to json' do
          expect(criteria.to_json).to eq(expected_json_with_test)
        end
        after { Cb.configuration.test_resources = false }
      end
    end

    let(:criteria) {
      Create.new
      .job_did('job_123')
      .is_submitted(false)
      .external_user_id('external_user_123')
      .vid('hamburger_avalanche')
      .bid('bid_123')
      .sid('sid_123')
      .site_id('site_123')
      .ipath_id('ipath_123')
      .tn_did('tn_123')
      .resume(resume)
      .cover_letter(cover_letter)
      .responses(responses)
    }
    let(:resume) {
      Resume.new
      .external_resume_id('external_resume_123')
      .resume_file_name('my resume')
      .resume_data(1010101010101)
      .resume_extension('pdf')
      .resume_title('Nurse')
    }
    let(:cover_letter) {
      CoverLetter.new
      .cover_letter_id('cover_letter_123')
      .cover_letter_text('yeah hi')
      .cover_letter_title('best nurse ever')
    }
    let(:responses) {
      [
        Response.new
        .question_id('question_123')
        .response_text('Yes please')
      ]
    }

    let(:expected_json) {
      {
        JobDID: criteria.job_did,
        IsSubmitted: criteria.is_submitted,
        ExternalUserID: criteria.external_user_id,
        VID: criteria.vid,
        BID: criteria.bid,
        SID: criteria.sid,
        SiteID: criteria.site_id,
        IPathID: criteria.ipath_id,
        TNDID: criteria.tn_did,
        Resume: {
          ExternalResumeID: resume.external_resume_id,
          ResumeFileName: resume.resume_file_name,
          ResumeData: resume.resume_data,
          ResumeExtension: resume.resume_extension,
          ResumeTitle: resume.resume_title
        },
        CoverLetter: {
          CoverLetterID: cover_letter.cover_letter_id,
          CoverLetterText: cover_letter.cover_letter_text,
          CoverLetterTitle: cover_letter.cover_letter_title
        },
        Responses: [{
          QuestionID: responses[0].question_id,
          ResponseText: responses[0].response_text
        }]
      }.to_json
    }
    let(:expected_json_with_test) {
      {
        JobDID: criteria.job_did,
        IsSubmitted: criteria.is_submitted,
        ExternalUserID: criteria.external_user_id,
        VID: criteria.vid,
        BID: criteria.bid,
        SID: criteria.sid,
        SiteID: criteria.site_id,
        IPathID: criteria.ipath_id,
        TNDID: criteria.tn_did,
        Resume: {
          ExternalResumeID: resume.external_resume_id,
          ResumeFileName: resume.resume_file_name,
          ResumeData: resume.resume_data,
          ResumeExtension: resume.resume_extension,
          ResumeTitle: resume.resume_title
        },
        CoverLetter: {
          CoverLetterID: cover_letter.cover_letter_id,
          CoverLetterText: cover_letter.cover_letter_text,
          CoverLetterTitle: cover_letter.cover_letter_title
        },
        Responses: [{
          QuestionID: responses[0].question_id,
          ResponseText: responses[0].response_text
        }],
        Test: true
      }.to_json
    }

  end
end
