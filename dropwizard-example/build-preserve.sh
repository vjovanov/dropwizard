#!/bin/sh

$GRAALVM_HOME/bin/native-image -H:+UnlockExperimentalVMOptions -H:ConfigurationFileDirectories=agent-metadata/ -H:ConfigurationFileDirectories=preserve-metadata/ --exact-reachability-metadata -Ob --enable-url-protocols=https --enable-url-protocols=http -H:Preserve=all -H:+MetadataTracingSupport --enable-sbom=false -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar

