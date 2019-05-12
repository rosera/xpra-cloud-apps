FROM gradle:4.10.0-jdk8
MAINTAINER Rich Rose <askrichardrose@gmail.com>

# Need Root for installation
USER root

ENV DEBIAN_FRONTEND noninteractive

# Set up the environment variables
ENV SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    STUDIO_URL="https://dl.google.com/dl/android/studio/ide-zips/3.4.0.18/android-studio-ide-183.5452501-linux.tar.gz" \
    ANDROID_BASE="/usr/local" \
    ANDROID_HOME="${ANDROID_BASE}/android-sdk" \
    ANDROID_VERSION=28 \
    ANDROID_BUILD_TOOLS_VERSION=27.0.3

#RUN apt-get update && apt-get install -y software-properties-common \
#        apt-transport-https \
#        ca-certificates \
#        curl \
#        gnupg \
#        --no-install-recommends

# Install XPRA
RUN curl https://winswitch.org/gpg.asc | apt-key add - && \
  echo "deb http://winswitch.org/ stretch main" > /etc/apt/sources.list.d/xpra.list && \
  apt-get update && \
  apt-get install -y xpra xvfb xterm && \
  apt-get clean && \ 
  rm -rf /var/lib/apt/lists/*


######## SAMPLE APPLICATION ##################
# Add Android Studio
RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_HOME/licenses/android-sdk-license" 
#    --no-install-recommends \
#    && rm -rf /var/lib/apt/lists/*

RUN $ANDROID_HOME/tools/bin/sdkmanager --update
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"

# Install Build Essentials
RUN apt-get update && apt-get install build-essential -y && apt-get install file -y && apt-get install apt-utils -y

# Install the Android Studio
RUN mkdir "${ANDROID_BASE}/android-studio" \
    && cd "${ANDROID_BASE}" \
    && curl $STUDIO_URL -o android-studio.tar.gz \
    && tar -xvf android-studio.tar.gz \
    && rm android-studio.tar.gz

ADD ascode.sh /usr/local/bin/ascode
RUN chmod +x /usr/local/bin/ascode

# Amend the working directory to local directory
WORKDIR ${ANDROID_BASE}/android-studio/bin

#ENV HOME /home/user

# Add xpra tester account
#RUN useradd --create-home --home-dir $HOME user \
#  && chown -R user:user $HOME

# DISPLAY
ENV DISPLAY=:100

# Add a Data volume
VOLUME /data

#WORKDIR /data

# Container Port
EXPOSE 10000

# USER
#USER user

# CMD to execute
CMD xpra start --bind-tcp=0.0.0.0:10000 --html=on --exit-with-children --daemon=no --xvfb="/usr/bin/Xvfb +extension  Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no --start-child=ascode
