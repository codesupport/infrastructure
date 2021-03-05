#!/bin/sh

rm -rf api
git clone https://github.com/codesupport/website-backend.git api
cd api
./mvnw package -P prod -Dmaven.test.skip=true
cd ..
java -jar api/target/api-service-0.0.1-SNAPSHOT.jar
