podman login registry.cph-1.eu-north-1.bitfarm.red:5000
podman build -t infra-container-podman:test .
podman push localhost/infra-container-podman:test registry.cph-1.eu-north-1.bitfarm.red:5000/d2osg/infra-container-podman:latest

podman run --pull always --privileged --network podman-services-public-ipv6 --network podman-services-integration-ipv6 -d --rm  --dns "2001:4860:4860::8888" registry.cph-1.eu-north-1.bitfarm.red:5000/d2osg/infra-container-podman:latest
