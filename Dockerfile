FROM openjdk:8-jdk-alpine
WORKDIR /home/kostya/
ADD ./target/*war ./
EXPOSE 8080
ENTRYPOINT [ "mvn spring-boot:run -Drun.arguments="spring.profiles.active=test""]
