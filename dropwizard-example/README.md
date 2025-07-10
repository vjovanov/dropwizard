# Introduction

The Dropwizard example application was developed to, as its name implies, provide examples of some of the features
present in Dropwizard.

# Overview

Included with this application is an example of the optional DB API module. The examples provided illustrate a few of
the features available in [Hibernate](http://hibernate.org/), along with demonstrating how these are used from within
Dropwizard.

This database example comprises the following classes:

* The `PersonDAO` illustrates using the Data Access Object pattern with assisting of Hibernate.

* The `Person` illustrates mapping of Java classes to database tables with assisting of JPA annotations.

* All the JPQL statements for use in the `PersonDAO` are located in the `Person` class.

* `migrations.xml` illustrates the usage of `dropwizard-migrations` which can create your database prior to running
your application for the first time.

* The `PersonResource` and `PeopleResource` are the REST resource which use the PersonDAO to retrieve data from the database, note the injection
of the PersonDAO in their constructors.

As with all the modules the db example is wired up in the `initialize` function of the `HelloWorldApplication`.

# Running The Application

To test the example application run the following commands.

* To create the example, package the application using [Apache Maven](https://maven.apache.org/) from the root dropwizard directory.

        cd dropwizard
        ./mvnw package
        cd dropwizard-example

* To set up the h2 database run.

        java -jar target/dropwizard-example-$DW_VERSION.jar db migrate example.yml

* To run the server run.

        java -jar target/dropwizard-example-$DW_VERSION.jar server example.yml

* To hit the Hello World example (hit refresh a few times).

	http://localhost:8080/hello-world

* To post data into the application.

	curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people

	open http://localhost:8080/people


# Building the Native Image
The build needs to be performed with Java 17:
```bash
./mvnw package
cd dropwizard-example
```

After building run the following:

```bash
./remove-from-jar.sh target/dropwizard-example-5.0.0-SNAPSHOT.jar META-INF/services/org.hibernate.bytecode.spi.BytecodeProvider
```

This will prevent the usage of byte budy in hibernate.

Then set `GRAALVM_HOME` to the latest GraalVM build.

The metadata is already in the repo, however, there are several scripts to collect the metadata:
1. `run-agent.sh` runs the Java agent and outputs `agent-metadata` and `agent-server-metadata` for two apps in this repo. The `agent-server-metadata` contains predefined classes which need a special patch to be generated (GR-67441). Currently, one can filter those classes with `remove-extra-defined-classes.sh`.
2. `build-preserve.sh` followed by `run-native-trace.sh` produces a native trace and stores it into `native-metadata` and `native-metadata-server`. This metadata needs slight cleanup due to GR-67321.

Finally, to build the native image use
```bash
$ ./build.sh
```
and to run
```bash
$ ./run.sh
```
