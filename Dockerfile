FROM openjdk:8-jdk-alpine
WORKDIR /home/kostya/
ADD ./target/*war ./
EXPOSE 8080
ENTRYPOINT [ "java","-jar","spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar"]
