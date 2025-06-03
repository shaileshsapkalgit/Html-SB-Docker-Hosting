# Use a lightweight base image with Java
FROM eclipse-temurin:17-jdk-jammy as build

# Set the working directory
WORKDIR /app

# Copy Maven/Gradle wrapper files and build descriptor files
COPY mvnw* pom.xml ./
COPY .mvn .mvn
COPY src src

# Build the app
RUN ./mvnw clean package -DskipTests

# Use a minimal JRE base image for runtime
FROM eclipse-temurin:17-jre-jammy

# Set the working directory
WORKDIR /app

# Copy the jar file from the builder stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
