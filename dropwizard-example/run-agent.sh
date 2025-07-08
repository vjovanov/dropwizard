#! /bin/bash

$GRAALVM_HOME/bin/java -agentlib:native-image-agent=config-merge-dir=agent-metadata -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar db migrate example.yml

$GRAALVM_HOME/bin/java -agentlib:native-image-agent=config-merge-dir=agent-metadata,experimental-class-define-support -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar server example.yml &

curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people



