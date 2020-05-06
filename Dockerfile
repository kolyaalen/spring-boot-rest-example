FROM openjdk:8-jdk-alpine
WORKDIR /home/kostya/
RUN apk update && apk add maven
ADD ./target/*war ./
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "-Dspring.profiles.active=test target/spring-boot-rest-example-0.5.0.war"]
