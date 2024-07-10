FROM gradle:jdk18
COPY . /src/homebrew-dash
WORKDIR /src/homebrew-dash

RUN ./gradlew src:main:java:net:carecentive:connector:build
RUN rm -f src/main/java/net/carecentive/connector/build/libs/*-plain.jar

EXPOSE 19191
EXPOSE 19192
EXPOSE 19193
EXPOSE 19194

CMD java -Dedc.keystore=src/main/resources/certs/cert.pfx \
-Dedc.keystore.password=123456 \
-Dedc.vault=src/main/resources/configuration/provider-vault.properties \
-Dedc.fs.config=src/main/resources/configuration/provider-configuration.properties \
-jar src/main/java/net/carecentive/connector/build/libs/connector.jar