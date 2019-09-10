FROM debian:stretch-slim
MAINTAINER Rich Rose <askrichardrose@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y software-properties-common \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        --no-install-recommends

# Install XPRA
RUN curl https://winswitch.org/gpg.asc | apt-key add - && \
  echo "deb http://winswitch.org/ stretch main" > /etc/apt/sources.list.d/xpra.list && \
  apt-get update && \
  apt-get install -y xpra xvfb xterm && \
  apt-get clean && \ 
  rm -rf /var/lib/apt/lists/*


######## SAMPLE APPLICATION ##################
# Add Intellij
WORKDIR /data
RUN curl -Lo ideaIC-2019.2.2.tar.gz https://download.jetbrains.com/idea/ideaIC-2019.2.2.tar.gz?_ga=2.190783467.1356621496.1568036178-968675117.1559931583 
RUN tar -xvf ideaIC-2019.2.2.tar.gz

RUN apt-get update && apt-get -y install \
        git \
        libasound2 \
        libatk1.0-0 \
        libcairo2 \
        libcups2 \
        libexpat1 \
        libfontconfig1 \
        libfreetype6 \
        libgtk2.0-0 \
        libpango-1.0-0 \
        libx11-xcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        openssh-client \
        --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*

ADD intellij.sh /usr/local/bin/intellij.sh
RUN chmod +x /usr/local/bin/intellij.sh
######## SAMPLE APPLICATION ##################

#ENV HOME /home/user

# Add xpra tester account
RUN useradd --create-home --home-dir $HOME user \
  && chown -R user:user $HOME

# DISPLAY
ENV DISPLAY=:100

# Add a Data volume
VOLUME /data

WORKDIR /data

# Container Port
EXPOSE 10000

# USER
USER user

# CMD to execute
#CMD xpra start --bind-tcp=0.0.0.0:10000 --html=on --exit-with-children --daemon=no --xvfb="/usr/bin/Xvfb +extension  Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no --start-child=intellij

CMD xpra start --bind-tcp=0.0.0.0:10000 --html=on --exit-with-children --daemon=no --xvfb="/usr/bin/Xvfb +extension  Composite -screen 0 1920x1080x16+24 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no --microphone=no --bandwidth-limit=10M --video-scaling=0 --start-child=intellij.sh
