FROM debian:bullseye

# Installer curl pour télécharger ctop
RUN apt-get update && apt-get install -y curl ca-certificates && \
    curl -Lo /usr/local/bin/ctop https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 && \
    chmod +x /usr/local/bin/ctop && \
    apt-get clean

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

# Launch CTOP
ENTRYPOINT ["/usr/local/bin/ctop"]
