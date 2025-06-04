# Step 1: Use an official Java runtime (Java 21) as a parent image for the build stage
FROM eclipse-temurin:21-jdk-jammy AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy the Maven wrapper and project files (pom.xml)
COPY mvnw* pom.xml ./
COPY .mvn .mvn

# Step 4: Copy the source code
COPY src src

# Step 5: Add execute permission to the mvnw wrapper
RUN chmod +x ./mvnw

# Step 6: Build the app using Maven
RUN ./mvnw clean package -DskipTests

# Step 7: Runtime stage: Use a smaller JRE image (Java 21) for running the app
FROM eclipse-temurin:21-jre-jammy

# Step 8: Set the working directory
WORKDIR /app

# Step 9: Copy the built JAR file from the build stage
COPY --from=build /app/target/my-springboot-app.jar /app/my-springboot-app.jar

# Step 10: Expose the port that the app will run on
EXPOSE 8080

# Step 11: Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "my-springboot-app.jar"]
