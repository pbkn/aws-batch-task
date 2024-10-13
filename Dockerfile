# Use Amazon Corretto 11 for Java 11
FROM public.ecr.aws/amazoncorretto/amazoncorretto:11.0.18-al2023-headless

# Set the working directory
WORKDIR /app

# Copy the Maven project (pom.xml and source code)
COPY pom.xml /app
COPY src /app/src

# Install Maven
RUN yum update -y  \
    && yum install -y maven \
    && mvn clean package -DskipTests

# Set the command to run the built JAR
CMD ["java", "-jar", "target/aws-batch-task-1.0-SNAPSHOT.jar"]