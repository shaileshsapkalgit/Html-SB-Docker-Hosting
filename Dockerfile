# Use an official Java runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the jar file into the container
COPY target/my-springboot-app.jar /app/my-springboot-app.jar

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "my-springboot-app.jar"]

# Expose the port that the app will run on
EXPOSE 8080
