# syntax=docker/dockerfile:1
FROM debian:bookworm

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

ENV NODE_MAJOR=20

# ==============================================================================
# Main dependencies

RUN apt-get update -qq \
  && apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  gosu \
  iputils-ping \
  procps \
  sudo \
  x11-utils \
  x11-xserver-utils \
  xvfb \
  && apt-get clean -y && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# install cron, chromium and chromedriver without recommended extras,
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
  cron \
  chromium \
  chromium-driver \
  fonts-liberation \
  libu2f-udev \
  udev \
  && apt-get clean -y && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# install node.js
RUN mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && apt-get update -qq \
  && apt-get install -y nodejs \
  && apt-get clean -y && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g selenium-webdriver

# ==============================================================================
# Add user
RUN addgroup --system --gid 1001 seleniumtest
RUN adduser --system --uid 1001 --home /home/seleniumtest seleniumtest --shell /bin/bash

WORKDIR /home/seleniumtest/

USER seleniumtest

COPY entrypoint.sh /home/seleniumtest/
COPY selenium_test.js /home/seleniumtest/
COPY selenium_manager_test.js /home/seleniumtest/

ENTRYPOINT [ "/home/seleniumtest/entrypoint.sh" ]
