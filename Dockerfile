FROM oracle/graalvm-ce:19.3.1-java11 AS build

RUN gu install native-image

COPY ./gradlew ./gradlew
COPY ./gradle ./gradle
COPY ./build.gradle ./build.gradle
COPY ./gradle.properties ./gradle.properties
COPY ./settings.gradle ./settings.gradle
COPY ./src ./src
RUN ./gradlew buildNative

FROM debian:latest
RUN mkdir /work
WORKDIR /work
COPY --from=build ./build/code-with-quarkus-1.0.0-SNAPSHOT-runner /work/application
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
