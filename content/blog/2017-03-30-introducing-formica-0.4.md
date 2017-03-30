+++
date = "2017-03-30"
title = "Introducing Formica: Release 0.4.0"

+++
Today I'm happy to ship version 0.4.0 of my CloudFormation tool [Formica](https://github.com/flomotlik/formica). While it isn't 1.0 yet because I want to include a few more features before that it is definitely production ready. I'm using it for all of my work and consulting.

I started building Formica because I missed a great CloudFormation client that doesn't introduce any further abstractions on top of CloudFormation, but has great UX. While for some use cases tools that add a little bit of abstraction on top of AWS can be helpful, e.g. managing an AWS API Gateway, too often we simply need a great UX to work with the abstractions AWS already provides and introducing more just makes our tooling more complex than it needs to be.

At the same time CloudFormation needs a way to make template files more modular, so Formica allows you to split your one template file into multipe files. These files will then be combined and deployed. Deployment always goes through ChangeSets so you can see exactly what is about to happen when you deploy. 

To increase modularity Formica even lets you pack modules into subfolders so you can share templates between projects through e.g. Git Submodules. This increases modularity and reuse, while staying close to the CloudFormation syntax.

And on top of that it includes jinja2 as a templating mechanism to be able to do a few dynamic things in your templates as well.

## Getting started

You can install formica with `pip install formica-cli`.

Formica works with any existing CloudFormation stack. You can copy the deployed template into a file named `stack.template.json` and in the same folder the file is in run `formica template` to see the template Formica picked up. It supports yaml or json, you can even mix them in the same folder.

Check out the [Quick Start Guide](https://github.com/flomotlik/formica#quick-start-guide) for more info on how to deploy and change your stack with Formica.

The [Documentation](https://github.com/flomotlik/formica/tree/master/docs) will give you an in-depth view into all the features. Also check out all existing commands as they might help you in your day to day development.

## 0.4.0 Release

### Diff Command

0.4.0 introduces a new `formica diff` command. While you could describe the ChangeSet in past versions and see what would happen once deployed, the ChangeSet doesn't give you a complete diff between your deployed and new template.

With formica diff you can see exactly what and how a template has changed:

```shell
root@61aaad32daf7:/app/docs/examples/s3-bucket# formica diff --stack teststack
+---------------------------------------------------------+------------------+----------------------------------+-----------------------+
|                          Path                           |       From       |                To                |      Change Type      |
+=========================================================+==================+==================================+=======================+
| Resources > DeploymentBucket > Properties               | Not Present      | {'BucketName': 'another-bucket'} | Dictionary Item Added |
+---------------------------------------------------------+------------------+----------------------------------+-----------------------+
| Resources > DeploymentBucket2 > Properties > BucketName | a-formica-bucket | a-bucket                         | Values Changed        |
+---------------------------------------------------------+------------------+----------------------------------+-----------------------+
```

This makes sure you always know 100% what is going to change in your infrastructure and there are no surprises.

### CloudFormation Yaml ShortCode support

AWS included a nice syntactic sugar in their yaml implementation with short codes. For example instead of having to write the following 

```yaml
MyEIP:
  Type: "AWS::EC2::EIP"
  Properties:
    InstanceId: 
      Ref: MyEC2Instance
```

you can write


```yaml
MyEIP:
  Type: "AWS::EC2::EIP"
  Properties:
    InstanceId: !Ref MyEC2Instance
```

Formica now supports all CloudFormation function short codes, leading to considerably shorter template files. Check out the [CF Intrinsic Functions docs](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html) for more details.

### Success when there are no changes

In the past Formica exited with a failure when the template that was to be deployed didn't contain any changes. Starting with 0.4.0 it will print a `No changes Found` message and exit with exit code 0. This makes it possible to include Formica in build scripts that don't contain changes everytime.


## Conclusions

In my opinion Serverless infrastructure specifically, but developing in the Cloud generally, depends on great tooling. AWS and other cloud providers are constantly introducing more abstractions on top of pure computing services. To get the most out of those high level services we need tools that stick to those abstractions, but improve on their existing UX.

Formica and other tools I've released or will release in the future are steps to make sure we have those kinds of tools. I will talk a little more about the tooling issue and how we have to work with existing abstractions in a future post and at ServerlessConf Austin in late April. If you have thoughts and want to chat about that ping me!