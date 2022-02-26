FROM debian:stretch-slim
MAINTAINER Rich Rose <askrichardrose@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y software-properties-common \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        xfce4 \
        --no-install-recommends

# Install XPRA
RUN curl https://xpra.org/gpg.asc | apt-key add - && \
  echo "deb https://xpra.org/ stretch main" > /etc/apt/sources.list.d/xpra.list && \
  apt-get update && \
  apt-get install -y xpra xvfb xterm && \
  apt-get clean && \ 
  rm -rf /var/lib/apt/lists/*
  
######## SAMPLE APPLICATION ##################
# Install Chrome
RUN apt-get update && apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        hicolor-icon-theme \
        libcanberra-gtk* \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libpangox-1.0-0 \
        libpulse0 \
        libv4l-0 \
        fonts-symbola \
        --no-install-recommends \
        && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
        && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
        && apt-get update && apt-get install -y \
        google-chrome-stable \
        --no-install-recommends \
        && apt-get purge --auto-remove -y curl \
        && rm -rf /var/lib/apt/lists/*

ADD chrome.sh /usr/local/bin/chrome.sh
RUN chmod +x /usr/local/bin/chrome.sh
######## SAMPLE APPLICATION ##################

#ENV HOME /home/user

# Add xpra tester account
RUN useradd --create-home --home-dir $HOME chrome \
  && chown -R chrome:chrome $HOME

# DISPLAY
ENV DISPLAY=:100

# Add a Data volume
VOLUME /data

WORKDIR /data

# Container Port
EXPOSE 10000

# USER
USER chrome

# CMD to execute
CMD xpra start --bind-tcp=0.0.0.0:10000 --html=on --exit-with-children --daemon=no --xvfb="/usr/bin/Xvfb +extension  Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no --start-child=chrome.sh
