# Use a base image with Java support
FROM openjdk:17.0.2-jdk

# Set the working directory in the container
WORKDIR /app

# Install a tool to download the JAR file (curl)
#RUN apt-get update && apt-get install -y curl

# Download the JAR file from the URL and copy it to the container
RUN curl -o app.jar http://65.2.126.105:8080/job/Gradle-Docker-K8s/ws/build/libs/Document_test-2-0.0.1.jar

# Define the command to run your Java application
CMD ["java", "-jar", "app.jar"]
