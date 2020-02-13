FROM oracle/graalvm-ce:19.3.1-java11

RUN gu install native-image

COPY ./gradlew ./gradlew
COPY ./gradle ./gradle
COPY ./build.gradle ./build.gradle
COPY ./gradle.properties ./gradle.properties
COPY ./settings.gradle ./settings.gradle

RUN ./gradlew buildNative

COPY build/*-runner /application
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
