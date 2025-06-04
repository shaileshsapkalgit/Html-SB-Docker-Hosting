# Build stage
FROM eclipse-temurin:21-jdk-jammy as build

# Set working directory in the container
WORKDIR /app

# Copy Maven wrapper and dependencies
COPY mvnw* pom.xml ./
COPY .mvn .mvn
COPY src src

# Add execute permission to mvnw wrapper
RUN chmod +x ./mvnw

# Build the app
RUN ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-jammy

# Set the working directory
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
