## Based on the antepenultiam stable debian
FROM debian:bullseye

## Update dependencies and get vsftpd
RUN apt-get update -y && \
    apt-get install -y vsftpd

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Create necessary directories
RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /etc/vsftpd && \
    mkdir -p /var/ftp && \
    mkdir -p /home/ftpuser

## Copy Configuration file
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

# Copy setup script and add rights
COPY tools/ftp_setup.sh /usr/local/bin/ftp_setup.sh
RUN chmod +x /usr/local/bin/ftp_setup.sh

## Launch PHP server as entrypoint
ENTRYPOINT ["/usr/local/bin/ftp_setup.sh"]