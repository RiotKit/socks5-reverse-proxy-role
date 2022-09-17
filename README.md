socks5-reverse-proxy-role
=========================

![architecture](./docs/architecture.png)

Ansible role for setting up a reverse TCP proxy to expose a service behind a socks5 (e.g. a TOR hidden service to "clear net").

The proxy passes data as-it-is, the TCP stream is not parsed nor modified.

TLS termination (if any) does not change.

**Features:**
- Forwarding TLS ports with load balancing
- Forwarding custom ports
- Local HTTP to HTTPS redirect
- TCP keep alive set by default
- Systemd integration
- Does not require Docker or Podman
- Runs on Debian and Ubuntu (tested on Debian with Molecule)

HTTP to HTTPS redirect
----------------------

In order to setup a HTTP to HTTPS redirect set the following:

```yaml
forward_http_port: true
```

Example of a load-balanced service
----------------------------------

There are three hidden services. Single NGINX gateway will load-balance the traffic between three hidden services.

```yaml
socks_port: 9050
socks_host: 127.0.0.1
forward_http_port: true
ports:
    - name: https-srv1
      local_port: 4001
      remote_port: 443
      remote_host: 11111111111111111111.onion
      systemd_enabled: true
      systemd_restart: true
      bind_ip: 127.0.0.1
      type: "tls"

    - name: https-srv2
      local_port: 4002
      remote_port: 443
      remote_host: 22222222222222222222.onion
      systemd_enabled: true
      systemd_restart: true
      bind_ip: 127.0.0.1
      type: "tls"

    - name: https-srv3
      local_port: 4003
      remote_port: 443
      remote_host: 33333333333333333333.onion
      systemd_enabled: true
      systemd_restart: true
      bind_ip: 127.0.0.1
      type: "tls"
```
