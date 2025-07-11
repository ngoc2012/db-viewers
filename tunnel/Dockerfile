FROM alpine:3.15

RUN apk add --no-cache openssh

# Add SSH private key and known_hosts
# COPY id_rsa /root/.ssh/id_rsa
# COPY known_hosts /root/.ssh/known_hosts

RUN chmod 600 /root/.ssh/id_rsa

# Entrypoint script
COPY start-tunnel.sh /start-tunnel.sh
RUN chmod +x /start-tunnel.sh

CMD ["/start-tunnel.sh"]
