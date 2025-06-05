# frozen_string_literal: true

# test/models/job_offer_test.rb
require 'test_helper'

class JobOfferTest < ActiveSupport::TestCase
  def setup
    @company = FactoryBot.create(:company)
    @job_offer_reference = FactoryBot.create(:job_offer_reference)
  end

  test 'should be valid' do
    job_offer = JobOffer.new(
      company: @company,
      job_offer_reference: @job_offer_reference,
      name: 'Desarrollador Ruby',
      status: :draft
    )
    assert job_offer.valid?
  end

  test 'should require a company' do
    job_offer = JobOffer.new(
      name: 'Desarrollador Ruby',
      status: :draft
    )
    assert_not job_offer.valid?
    assert_includes job_offer.errors[:company], 'must exist'
  end

  test 'should have valid status' do
    job_offer = JobOffer.new(
      company: @company,
      job_offer_reference: @job_offer_reference,
      name: 'Desarrollador Ruby'
    )
    assert job_offer.valid?
    assert_equal 'draft', job_offer.status
  end
end
