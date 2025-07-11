FROM alpine:latest AS builder

# OpenJDK, curl, tar 설치
RUN apk update && \
    apk add --no-cache openjdk8 curl tar

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV CATALINA_HOME=/usr/local/tomcat
ENV TOMCAT_VERSION=9.0.100

# Tomcat 다운로드 및 설정
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mkdir -p $CATALINA_HOME && \
    tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C $CATALINA_HOME --strip-components=1 && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm -rf $CATALINA_HOME/webapps/* && \
    mkdir -p $CATALINA_HOME/webapps/ROOT/

COPY mariadb-java-client-2.4.0.jar /usr/local/tomcat/lib/

COPY favicon.ico /usr/local/tomcat/webapps/ROOT/

COPY index.jsp /usr/local/tomcat/webapps/ROOT/
COPY login.jsp /usr/local/tomcat/webapps/ROOT/
COPY logout.jsp /usr/local/tomcat/webapps/ROOT/
COPY tomcat.css /usr/local/tomcat/webapps/ROOT/
COPY register.jsp /usr/local/tomcat/webapps/ROOT/

RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF
COPY web.xml /usr/local/tomcat/webapps/ROOT/WEB-INF

FROM alpine:latest

# OpenJDK 설치
RUN apk add --no-cache openjdk8-jre-base && \
    rm -rf /var/cache/apk/*

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

# Build 단계에서 Tomcat 복사
COPY --from=builder $CATALINA_HOME $CATALINA_HOME

EXPOSE 8080

# Tomcat 실행
CMD ["sh","-c","${CATALINA_HOME}/bin/catalina.sh run"]