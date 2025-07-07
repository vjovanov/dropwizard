#! /bin/bash

$GRAALVM_HOME/bin/java -agentlib:native-image-agent=config-merge-dir=agent-metadata -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar db migrate example.yml
