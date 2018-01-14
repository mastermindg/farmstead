# farmstead

[![Gem Version](https://badge.fury.io/rb/farmstead.svg)](https://badge.fury.io/rb/farmstead)
[![Build Status](https://api.travis-ci.org/mastermindg/farmstead.svg?branch=master)](http://travis-ci.org/mastermindg/farmstead)

Farmstead is a modular data pipeline platform. Farmstead makes creating and deploying a fully-functional data pipeline a snap. Farmstead uses containers to encapsulate the middleware which allows for a super-fast deployment and prototyping process.


## Table of Contents

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 orderedList:0 -->

- [Getting started](#getting-started)
    - [Configuration](#configuration)
        + [Configuration Options](#config-options)
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
```

Once the project is created cd to the directory and deploy to get started:

```
cd myproject
farmstead deploy
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

#### Configuration Options

**Database**

The default database is MySQL but can be set to either MySQL, Postgres, or SQLLite. Extensions will be available 

**Kafka**

The default is to advertise the IP address assigned to the host. If you're behind a firewall or a load-balancer and want to change it you anything you want. Here's an example:

```yaml
kafka:
    - advertise_from_local_ip: false
    - advertised_ip: 192.168.1.2
```

You can use a custom Zookeeper cluster if you have one. Just set the zookeeper_address in the config.

You can also create custom topics outside of the default Wood, Field, Forest, and Road. 

### Environment Variables

Farmstead builds projects on Docker. In order to keep secrets out of the Rails code we use environment varibles. These are read from the .env file at the root of the project. This is IGNORED in Git, so be sure to keep these safe in a deployment/build system (i.e. Jenkins).

Keep in mind that you can always customize the Rails application using further using more environment variables as well.

### Deployment Methods

The default method is Docker. It is also possible to deploy using Rancher and Kubernetes (on top of Docker). To deploy using another method use the -x flag:


```
farmstead new myproject -x kubernetes
```

## Architecture

Kafka and Database 

ETL

* Extract
* Transform
* Load

All of the services are only running a Kafka consumer and producer. There is a Manager service that 

**Classes:**

### Farmstead::Manager

Task scheduling, batch processing, and general flow control. Exposes a very simple web service where you can pull logs and see the data in real-time.

### Farmstead::Extract

Extracts the data from the source.

### Farmstead::Transform

Transforms one or more datasets.

### Farmstead::Load

Loads the data into a database.

## License

MIT
