#! /bin/bash

./dropwizard-example-5.0.0-SNAPSHOT -XX:MissingRegistrationReportingMode=Warn db migrate example.yml

./dropwizard-example-5.0.0-SNAPSHOT -XX:MissingRegistrationReportingMode=Warn server example.yml &
pid=$!

echo Send requests after 5 seconds
sleep 5

for i in {1..100}
do
  curl -H "Content-Type: application/json" -X POST -d '{"fullName":"Other Person","jobTitle":"Other Title"}' http://localhost:8080/people
  sleep 1
done
echo Killing the server
kill $pid
