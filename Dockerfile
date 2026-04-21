# ---------- Stage 1: Build ----------
FROM maven:3.9-eclipse-temurin-8 AS builder

WORKDIR /app

# Copy everything
COPY . .

# Build the jar
RUN mvn clean package -DskipTests


# ---------- Stage 2: Run ----------
FROM eclipse-temurin:8-jdk

WORKDIR /app

# Copy jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
