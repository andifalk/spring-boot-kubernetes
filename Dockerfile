FROM openjdk:11-jdk
COPY build/libs/kube-hello-1.0.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
