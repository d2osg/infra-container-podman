FROM nginx:latest
RUN apt-get update && apt-get install --no-install-recommends --yes nftables iproute2 inetutils-ping
ADD files/nftables.conf /etc/nftables.conf 
ADD files/docker-entrypoint.sh /docker-entrypoint.d/docker-entrypoint.sh

