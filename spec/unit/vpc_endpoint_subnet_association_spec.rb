# frozen_string_literal: true

require 'spec_helper'

describe 'VPC endpoint subnet association' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'does not create a VPC endpoint subnet association' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_vpc_endpoint_subnet_association'))
    end
  end

  context 'when custom tags provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.subnet_ids = %w[1 2]
      end
    end

    it 'creates a VPC endpoint subnet association for each subnet id' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint_subnet_association')
              .with_attribute_value(:subnet_id, '1'))
    end

    it 'creates a VPC endpoint subnet association for each subnet id' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_vpc_endpoint_subnet_association')
              .with_attribute_value(:subnet_id, '2'))
    end
  end
end
