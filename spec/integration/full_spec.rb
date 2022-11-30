# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(role: :full)
  end

  let(:vpc_endpoint_id) do
    output(role: :full, name: 'vpc_endpoint_id')
  end

  describe 'VPC endpoint' do
    subject { vpc_endpoints(vpc_endpoint_id) }

    it { is_expected.to(exist) }
  end
end
