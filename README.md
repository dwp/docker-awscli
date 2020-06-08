# docker-awscli
Repository for `docker-awscli`

https://hub.docker.com/repository/docker/dwpdigital/awscli

# Usage

This container can be used with no arguments or environment variables, and will 
provide a container which is based off of the `govermentpaas/awscli` container.

It also provides a file at `/assumerole`, the use of which is optional. If used,
it expects to be provided an `AWS_ROLE_ARN` environment variable and will export 
`AWS_SECRET_ACCESS_KEY`, `AWS_ACCESS_KEY_ID` and `AWS_SESSION_TOKEN` environmental 
variables for use in-session.

No further configuration is required once the `source /assume-role` has been parsed 
as the values obtained from STS are exported as environmental variables and can 
therefore be used by AWS CLI calls.


# Examples
This example is quite generic. To use this in a Concourse pipeline:

    task: my-interesting-task-name
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: dwpdigital/awscli
      params:
        AWS_ROLE_ARN: arn:aws:iam::[YOUR_AWS_ACCOUNT_NUMBER]:role/[YOUR_AWS_ROLE_TO_ASSUME]
      run:
        path: sh
        args:
          - -exc
          - |
            source /assume-role
            aws --version
            
Of course in place of `aws --version` you can have any AWS CLI command that is privileged 
to run.


This example is quite specific to a DataWorks implementation. To use this in a 
Concourse pipeline that has been configured to use [`dataworks-secrets`](https://github.ucds.io/dip/dataworks-secrets):

    my-interesting-task-name:
      task: my-interesting-task-name
      config:
        platform: linux
        image_resource:
          type: docker-image
          source:
            repository: ((dataworks.docker_awscli_repository))
            tag: ((dataworks.docker_awscli_version))
        params:
          AWS_ROLE_ARN: arn:aws:iam::((dataworks.aws_management_acc)):role/ci
        run:
          path: sh
          args:
            - -exc
            - |
              source /assume-role
              aws lambda invoke --function-name ami_builder --invocation-type RequestResponse --payload file://manifest/manifest.json --cli-connect-timeout 900 --cli-read-timeout 900 output.json

