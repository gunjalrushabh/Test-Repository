# Use a base image with Java support
FROM openjdk:17.0.2-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the Jenkins workspace to the container
COPY http://15.207.86.160:8080/job/CBSBuildTestJob/ws/build/libs/Document_test-2-0.0.1.jar /app/app.jar

# Define the command to run your Java application
CMD ["java", "-jar", "app.jar"]
