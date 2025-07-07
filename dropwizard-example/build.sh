#!/bin/sh

$GRAALVM_HOME/bin/native-image -H:+UnlockExperimentalVMOptions -H:ConfigurationFileDirectories=agent-metadata/ -H:ConfigurationFileDirectories=native-metadata/ -H:ConfigurationFileDirectories=manual-metadata/ --exact-reachability-metadata -Ob --enable-url-protocols=https --enable-url-protocols=http -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar
