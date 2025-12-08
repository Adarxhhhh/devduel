FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY ../pom.xml ../pom.xml
COPY pom.xml .
COPY src src
RUN cd .. && ./mvnw -pl challenge-service -am package -DskipTests

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "app.jar"]
