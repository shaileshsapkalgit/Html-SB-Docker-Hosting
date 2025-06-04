# Use an OpenJDK base image for building the app
FROM eclipse-temurin:21-jdk-jammy as build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper and pom.xml files
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Copy the entire source code
COPY src src

# Add execute permission to mvnw
RUN chmod +x ./mvnw

# Build the application using Maven
RUN ./mvnw clean package -DskipTests

# Use a smaller JRE image for runtime
FROM eclipse-temurin:21-jre-jammy

# Set the working directory in the container
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
