FROM openjdk:8-jdk-alpine
COPY ./helloWorld/initial/target/helloWorld.war /usr/app/
WORKDIR /user/app
EXPOSE 8080
ENTRYPOINT [ "java" , "-jar", "helloWorld.war"]
