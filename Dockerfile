FROM java:8-jdk-alpine
ENV SPOTBUGS_VERSION=3.1.6
ENV FINDSECBUGS_VERSION=1.8.0

WORKDIR /usr/workdir
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*

RUN curl -sL \
      http://repo.maven.apache.org/maven2/com/github/spotbugs/spotbugs/${SPOTBUGS_VERSION}/spotbugs-${SPOTBUGS_VERSION}.tgz | \
    tar -xz  && \
    mv spotbugs-* /usr/bin/spotbugs

RUN curl -o /usr/bin/spotbugs/lib/findsecbugs-plugin.jar -sL "https://search.maven.org/remotecontent?filepath=com/h3xstream/findsecbugs/findsecbugs-plugin/${FINDSECBUGS_VERSION}/findsecbugs-plugin-${FINDSECBUGS_VERSION}.jar"

WORKDIR /workdir

ENTRYPOINT ["java","-jar","/usr/bin/spotbugs/lib/spotbugs.jar","-pluginList","/usr/bin/spotbugs/lib/findsecbugs-plugin.jar"]
CMD ["-h"]

