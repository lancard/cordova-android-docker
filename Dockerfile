FROM ubuntu:22.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install npm openjdk-11-jdk wget unzip curl vim net-tools -y

RUN npm install -g n
RUN n lts
RUN npm install -g npm@latest

RUN node -v
RUN npm -v

RUN npm install -g cordova

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip?hl=ko -O cmdlinetools.zip -nc
RUN unzip cmdlinetools.zip
RUN rm cmdlinetools.zip

RUN wget -q https://services.gradle.org/distributions/gradle-8.6-bin.zip -nc
RUN unzip gradle-8.6-bin.zip
RUN rm gradle-8.6-bin.zip

ENV ANDROID_HOME=/cmdline-tools/
ENV ANDROID_SDK_ROOT=/cmdline-tools/
ENV PATH="${PATH}:/gradle-8.6/bin:/cmdline-tools/bin"
RUN yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "cmdline-tools;12.0"
RUN yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;34.0.0"

ENTRYPOINT ["/app/run.sh"]
