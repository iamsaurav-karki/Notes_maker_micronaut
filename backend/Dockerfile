FROM gradle:8.5.0-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle shadowJar --no-daemon

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
COPY --from=build /app/src/main/resources/application.yml /app/src/main/resources/application.yml
COPY --from=build /app/src/main/resources/application.yml /app/application.yml
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"] 