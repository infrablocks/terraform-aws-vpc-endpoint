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
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 'execute-api'
        vars.vpc_endpoint_type = 'Interface'
      end
    end

    it 'does not create a VPC endpoint subnet association' do
      expect(@plan)
        .not_to(include_resource_creation(
                  type: 'aws_vpc_endpoint_subnet_association'
                ))
    end
  end

  context 'when subnet IDs provided' do
    before(:context) do
      @subnet_ids = %w[subnet-12345678 subnet-23456789]
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 'execute-api'
        vars.vpc_endpoint_type = 'Interface'
        vars.vpc_endpoint_subnet_ids = @subnet_ids
      end
    end

    it 'creates a VPC endpoint subnet association for each subnet id' do
      @subnet_ids.each do |subnet_id|
        expect(@plan)
          .to(include_resource_creation(
            type: 'aws_vpc_endpoint_subnet_association'
          )
                .with_attribute_value(:subnet_id, subnet_id))
      end
    end
  end

  context 'when subnet IDs is an empty list' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.vpc_endpoint_service_common_name = 'execute-api'
        vars.vpc_endpoint_type = 'Interface'
        vars.vpc_endpoint_subnet_ids = []
      end
    end

    it 'does not create a VPC endpoint subnet association' do
      expect(@plan)
        .not_to(include_resource_creation(
                  type: 'aws_vpc_endpoint_subnet_association'
                ))
    end
  end
end
