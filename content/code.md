+++
title = "code"
date = "2017-01-13T14:11:24+01:00"

+++

## [Formica](https://github.com/flomotlik/formica)

A CloudFormation stack management and template building tool. Designed to make CF easy and building CF templates moduler

## [AWSIE](https://github.com/flomotlik/awsie)

CloudFormation aware wrapper for the awscli so you can get the physicalID of resources for a call to the awscli from CloudFormation:

```shell
awsie example-stack s3 ls s3://cf:DeploymentBucket: --region us-west-1
```

gets translated to:

```shell
aws s3 ls s3://formica-example-stack-deploymentbucket-1jjzisylxreh9 --region us-west-1
```

For more check out my [Github profile](https://github.com/flomotlik).
