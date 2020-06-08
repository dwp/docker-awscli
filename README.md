# docker-awscli
Repository for `docker-awscli`

https://hub.docker.com/repository/docker/dwpdigital/awscli

# Usage & Examples

This container can be used with no arguments or environment variables, and will 
provide a container which is based off of the `govermentpaas/awscli` container.

It also provides a file at `/assumerole`, the use of which is optional. If used,
it expects to be provided an `AWS_ROLE_ARN` environment variable and will export 
`AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID` and `AWS_SESSION_TOKEN` environmental 
variables for use in-session.

For example, to use this in a Concourse pipeline:

    my-interesting-task-name:
      task: my-interesting-task-name
      config:
        platform: linux
        image_resource:
          type: docker-image
          source:
            repository: dwpdigital/awscli
        params:
          AWS_ROLE_ARN: arn:aws:iam::((dataworks.aws_management_acc)):role/ci
          AWS_REGION: ((dataworks.aws_region))
        run:
          path: sh
          args:
            - -exc
            - |
              source /assume-role
              aws lambda invoke --function-name ami_builder --invocation-type RequestResponse --payload file://manifest/manifest.json --cli-connect-timeout 900 --cli-read-timeout 900 output.json

No further configuration is required once the `source /assume-role` has been parsed 
as the values obtained from STS are exported as environmental variables and can 
therefore be used by AWS CLI calls.
