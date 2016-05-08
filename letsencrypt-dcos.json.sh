#!/bin/bash -x

version=$(git rev-parse HEAD 2>/dev/null | cut -c 1-7)

cat <<EOF
{
  "id": "/letsencrypt-dcos",
  "cpus": 0.05,
  "mem": 128,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "volumes": [{
      "containerPath": "/etc/letsencrypt",
      "hostPath": "/var/lib/letsencrypt",
      "mode": "RW"
    }],
    "docker": {
      "image": "brentley/letsencrypt-dcos:$version",
      "network": "BRIDGE",
      "portMappings": [{
        "containerPort": 80,
        "hostPort": 0,
        "servicePort": 10000,
        "protocol": "tcp"
      }]
    }
  },
  "env": {
    "MARATHON_URL": "http://master.mesos:8080",
    "MARATHON_LB_ID": "marathon-lb",
    "SSL_EMAIL": "blangston@cloudpassage.com",
    "SSL_DOMAINS": "global-cphalo.cphalo.com,api-cphalo.cphalo.com,grid-cphalo.cphalo.com,portal-cphalo.cphalo.com,outyet-cphalo.cphalo.com"

  },
  "labels": {
    "HAPROXY_0_VHOST": "global-cphalo.cphalo.com,api-cphalo.cphalo.com,grid-cphalo.cphalo.com,portal-cphalo.cphalo.com,outyet-cphalo.cphalo.com",
    "HAPROXY_0_PATH": "/.well-known/acme-challenge",
    "HAPROXY_GROUP": "external"
  }
}
EOF
