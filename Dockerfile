# Build stage
FROM eclipse-temurin:17-jdk-jammy AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD ./app $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

# Package stage
FROM eclipse-temurin:17-jre-jammy
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
ENV SERVER_PORT 5000
#COPY ./app/wait-for-db.sh /usr/wait-for-db.sh
#RUN chmod +x /usr/wait-for-db.sh
EXPOSE 5000
#ENTRYPOINT ./wait-for-db.sh db:13306 -- java -jar /app/runner.jar
ENTRYPOINT java -jar /app/runner.jar
