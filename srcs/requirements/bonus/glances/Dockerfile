# Based on the antepenultimate stable debian
FROM debian:bullseye

# Get Dependencies
RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-pip \
    gcc \
    python3-dev \
    libffi-dev \
    libssl-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Glances with Docker support
RUN pip3 install --no-cache-dir glances[web,docker] docker

# Copy configuration file
COPY ./conf/glances.conf /etc/glances/glances.conf

# Create directories for logs
RUN mkdir -p /var/log/glances

# Expose port
EXPOSE 61208

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:61208/api/3/status || exit 1

# Launch Glances server as root (nécessaire pour Docker socket)
ENTRYPOINT ["glances", "-C", "/etc/glances/glances.conf", "-w"]