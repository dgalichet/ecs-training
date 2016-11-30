FROM openjdk:8-alpine
MAINTAINER David Galichet
RUN apk --update-cache add bash
ADD target/universal/stage /opt/hello-scala
EXPOSE 9000
CMD ["/opt/hello-scala/bin/hello-scala"]
