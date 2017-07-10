FROM jetbrains/teamcity-agent:2017.1.1

MAINTAINER Paweł Gajda

ENV GRADLE_HOME=/usr/bin/gradle

RUN apt-get update
RUN apt-get install -y --force-yes expect git mc gradle unzip \
    wget curl libc6-i386 lib32stdc++6 lib32gcc1 \
    lib32ncurses5 lib32z1
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD android-accept-licenses.sh /opt/tools/
ENV PATH ${PATH}:/opt/tools
ENV LICENSE_SCRIPT_PATH /opt/tools/android-accept-licenses.sh

RUN cd /opt && wget --output-document=android-tools.zip \
    https://dl.google.com/android/repository/tools_r25.2.5-linux.zip && \
    unzip android-tools.zip -d android-sdk-linux && \
    chown -R root.root android-sdk-linux

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN ${LICENSE_SCRIPT_PATH} \
    "android update sdk --all --no-ui --filter platform-tools,build-tools-25.0.3,android-25, android-26,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services"
