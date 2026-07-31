## Unreleased

BACKWARDS INCOMPATIBILITIES / NOTES:

* The minimum supported AWS provider version is now `>= 5.100` (previously
  `>= 4.0`). Consumers still on AWS provider v4, or on v5 below 5.100, will
  need to upgrade before adopting this version.

  Destroying a VPC endpoint with more than one entry in
  `vpc_endpoint_subnet_ids` could fail with
  `OperationInProgress: VpcEndpoint modify operation in progress`. AWS
  serialises modify operations per endpoint, and the provider deleted the
  subnet associations in parallel, so all but the first were rejected. The
  provider fixed this in 5.100.0 by taking the same per-endpoint mutex on
  delete that it already took on create
  ([hashicorp/terraform-provider-aws#42884](https://github.com/hashicorp/terraform-provider-aws/pull/42884)).

  No module inputs or outputs change, and no state migration is required.
