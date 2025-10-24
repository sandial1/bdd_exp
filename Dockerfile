# Use Debian-based Node image (not Alpine)
FROM node:22-bookworm

# Enable pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install Chrome and XVFB
RUN apt-get update && apt-get install -y \
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
    && rm -rf /var/lib/apt/lists/*

# Environment for Chrome
ENV CHROME_BIN=/usr/bin/chromium \
    CHROME_PATH=/usr/lib/chromium/ \
    NODE_ENV=development \
    DISPLAY=:99

WORKDIR /usr/src/app

COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --dangerously-allow-all-builds
COPY . .

# Optional: expose Chrome debug port
EXPOSE 9222

# Default command: run WDIO under virtual display
CMD sh -c "Xvfb :99 -screen 0 1280x1024x24 & pnpm test"
