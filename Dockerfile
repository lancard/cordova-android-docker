FROM ubuntu:24.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install npm openjdk-17-jdk wget unzip curl vim net-tools -y

RUN npm install -g n
RUN n lts
RUN npm install -g npm@latest

RUN node -v
RUN npm -v

RUN npm install -g cordova-android
RUN npm list -g cordova-android

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-11391160_latest.zip?hl=ko -O cmdlinetools.zip -nc
RUN unzip cmdlinetools.zip
RUN rm cmdlinetools.zip

RUN wget -q https://services.gradle.org/distributions/gradle-8.14.2-bin.zip -nc
RUN unzip gradle-8.14.2-bin.zip
RUN rm gradle-8.14.2-bin.zip

ENV ANDROID_HOME=/cmdline-tools/
ENV ANDROID_SDK_ROOT=/cmdline-tools/
ENV PATH="${PATH}:/gradle-8.14.2/bin:/cmdline-tools/bin"
RUN yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "cmdline-tools;19.0"
RUN yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "build-tools;35.0.1"

CMD ["tail", "-f", "/dev/null"]
