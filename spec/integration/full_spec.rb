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

  let(:security_group_id) do
    output(role: :full, name: 'security_group_id')
  end

  describe 'VPC endpoint' do
    subject { vpc_endpoints(vpc_endpoint_id) }

    it { is_expected.to(exist) }

    its('groups.first.group_id') { is_expected.to eq security_group_id }
  end
end
