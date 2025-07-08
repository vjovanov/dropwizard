#! /bin/bash

./dropwizard-example-5.0.0-SNAPSHOT-preserve -XX:RecordMetadata=path=./native-metadata/ -XX:MissingRegistrationReportingMode=Warn db migrate example.yml

echo Running server
./dropwizard-example-5.0.0-SNAPSHOT-preserve -XX:RecordMetadata=path=./native-metadata-server/ -XX:MissingRegistrationReportingMode=Warn server example.yml &


echo Send requests after 5 seconds
sleep 5

for i in {1..10}
do
  curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
done