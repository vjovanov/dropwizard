#! /bin/bash

echo Running DB migration
$GRAALVM_HOME/bin/java -agentlib:native-image-agent=config-merge-dir=agent-metadata -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar db migrate example.yml


echo Running server
$GRAALVM_HOME/bin/java -agentlib:native-image-agent=config-output-dir=agent-server-metadata,experimental-class-define-support -jar target/dropwizard-example-5.0.0-SNAPSHOT.jar server example.yml &

pid=$!

echo Send requests after 50 seconds
sleep 50

for i in {1..20}
do
  curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
  sleep 1
done

sleep 1
echo Killing server
kill $pid

