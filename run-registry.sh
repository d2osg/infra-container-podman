
echo "openssl genrsa -des3 -out /opt/registry/certs/domain.key 2048"
echo "openssl req -new -key /opt/registry/certs/domain.key -out /opt/registry/certs/domain.csr"
echo "cp domain.key domain.key.org"
echo "openssl rsa -in domain.key.org -out domain.key"
echo "#openssl x509 -req -in domain.csr -signkey domain.key -out domain.crt -days 3650 -sha256 -extfile v3.ext"
echo "cp domain.crt /usr/local/share/ca-certificates/"
echo "**********************"
echo " To remove:  rm /etc/pki/ca-trust/source/anchors/domain.crt"
echo "**********************"
echo " End with update-ca-certificates"
echo "**********************"
podman run --name registry --privileged --network podman-services-public-ipv6  \
-v /opt/registry/data:/var/lib/registry:z \
-v /opt/registry/auth:/auth:z \
-e "REGISTRY_AUTH=htpasswd" \
-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
-v /opt/registry/certs:/certs:z \
-e "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt" \
-e "REGISTRY_HTTP_TLS_KEY=/certs/domain.key" \
-e REGISTRY_COMPATIBILITY_SCHEMA1_ENABLED=true \
--rm \
--dns "2001:4860:4860::8888"  \
-d \
docker.io/library/registry:latest
