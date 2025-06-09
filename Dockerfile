# Use an official Java 17 runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from your local machine into the container
COPY target/my-springboot-app.jar /app/my-springboot-app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "my-springboot-app.jar"]
