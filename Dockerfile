FROM java:8-jdk-alpine
COPY ./helloWorld/initial/target/helloWorld.war /usr/app/
WORKDIR /usr/app
EXPOSE 8080
RUN apk update && apk add bash
ENTRYPOINT [ "java","-jar", "helloWorld.war"]
