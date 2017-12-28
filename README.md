# farmstead

[![Gem Version](https://badge.fury.io/rb/farmstead.svg)](https://badge.fury.io/rb/farmstead)
[![Build Status](https://api.travis-ci.org/mastermindg/farmstead.svg?branch=master)](http://travis-ci.org/mastermindg/farmstead)

Farmstead is a modular data pipeline platform. Farmstead makes creating and deploying a fully-functional data pipeline a snap. It is built on top of Rails/Ruby and uses Docker. This combination allows for a super-fast deployment and prototyping process.


## Table of Contents

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 orderedList:0 -->

- [Getting started](#getting-started)
    - [Configuration](#configuration)
    - [Environment Variables](#env)
    - [Deployment Methods](#deployment)
- [Architecture](#architecture)
    - [Scheduler - Glenda](#glenda)
    - [Fertilize - Tinman](#tinman)
    - [Harvest - Scarecrow](#scarecrow)
    - [Mill - CowardlyLion](#cowardlylion)
    - [Serve - Dorothy](#dorothy)
- [License](#license)

<!-- /TOC -->


## Getting Started

To get started you'll need to install the Farmstead gem:

```ruby
gem install farmstead
```

To create a new Farmstead project:

```
farmstead new myproject
cd myproject
farmstead start
```

### Configuration

Farmstead tries to follow Rails conventions. Some of the configuration options are available from the command-line. For instance, to chose a different database techhnology use the -d flag:

```
farmstead new myproject -d postgres
```

There are default values for database users and passwords. For more advanced usages you can use a configuration file. A configuration file must be written in YAML and is passed to Farmstead via command-line:

```
farmstead new myproject -c myproject.yml
```

An example configuration file is included.

### Environment Variables

Farmstead builds projects on Docker. In order to keep secrets out of the Rails code we use environment varibles. These are read from the .env file at the root of the project. This is IGNORED in Git, so be sure to keep these safe in a deployment/build system (i.e. Jenkins).

Keep in mind that you can always customize the Rails application using further using more environment variables as well.

### Deployment Methods

The default method is Docker. It is also possible to deploy using Rancher and Kubernetes (on top of Docker). To deploy using another method use the -x flag:


```
farmstead new myproject -x kubernetes
```

## Architecture

Kafka and Database ETL

Presently only Dorothy is running Rails. The rest of the services are only running a Kafka consumer and producer. Eventually that will change.

### Scheduler - Glenda

Glenda

### Fertilize - Tinman

Tinman

### Harvest - Scarecrow

Scarecrow

### Mill - CowardlyLion

Cowardlylion

### Serve - Dorothy

Dorothy

## License

MIT


## TODO

1. Find out how to create roles for Dorothy
2. Get Micro-services working
3. Figure out how to get Selenium working or if it's necessary (Selenium)

