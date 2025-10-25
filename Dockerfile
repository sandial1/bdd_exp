FROM node:22-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    CHROME_BIN=/usr/bin/chromium \
    CHROME_PATH=/usr/lib/chromium/ \
    NODE_ENV=development \
    DISPLAY=:99

# Enable pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install Chromium + Xvfb and minimal runtime deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    xvfb \
    fonts-liberation \
    libnss3 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libdrm2 \
    libxkbcommon0 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libxcomposite1 \
    libasound2 \
    ca-certificates \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# leverage Docker layer cache for deps
COPY package.json pnpm-lock.yaml* ./

RUN pnpm install --frozen-lockfile

COPY . .

# create non-root user and fix ownership
#RUN groupadd -r wdio && useradd -r -g wdio -s /usr/sbin/nologin wdio \
#    && chown -R wdio:wdio /usr/src/app
RUN groupadd -r wdio && useradd -r -g wdio -s /usr/sbin/nologin wdio

# add entrypoint to start Xvfb
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 9222

HEALTHCHECK --interval=1m --timeout=10s --start-period=10s CMD pgrep Xvfb || exit 1

USER wdio

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["pnpm","test"]
