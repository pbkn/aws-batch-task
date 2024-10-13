# Use Amazon Corretto 11 for Java 11 ref: https://gallery.ecr.aws/amazoncorretto/amazoncorretto
FROM public.ecr.aws/amazoncorretto/amazoncorretto:11.0.18-al2023-headless

# Set the working directory
WORKDIR /app

# Copy the Maven project (pom.xml and source code)
COPY pom.xml /app
COPY src /app/src

# Install Maven with default JAVA_HOME from the base image
RUN yum update -y && \
    yum install -y maven && \
    export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))" && \
    echo "JAVA_HOME is set to $JAVA_HOME" && \
    export PATH="$JAVA_HOME/bin:$PATH" && \
    mvn clean package -DskipTests

# Set the command to run the built JAR
CMD ["java", "-jar", "target/aws-batch-task-1.0-SNAPSHOT.jar"]