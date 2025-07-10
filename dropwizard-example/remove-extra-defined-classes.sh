#!/bin/bash

jq '
map(
  if .type == "agent-extracted" and (.classes | type == "array") then
    .classes |= map(select(.nameInfo | startswith("io/dropwizard/jersey/DropwizardResourceConfig$SpecificBinder_")))
  else
    .
  end
)
' agent-server-metadata/predefined-classes-config.json > /tmp/filtered.json

cp /tmp/filtered.json agent-server-metadata/predefined-classes-config.json