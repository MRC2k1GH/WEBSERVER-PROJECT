**High Availability WordPress Blog**

This project demonstrates a highly available WordPress setup designed for robust performance, monitoring, and fault tolerance. It utilizes a distributed architecture with multiple web servers, databases, load balancers, and monitoring tools.

Architecture Overview
The system consists of the following components:

1. **WordPress Web Servers**
Count: 3 instances of WordPress.
Technology: PHP, MySQL client.
High Availability: Load-balanced using Nginx.
Cloudflare Integration: Web traffic is routed through a Cloudflare Tunnel.
Automation: DNS records and Cloudflare tunnel configuration are automated via Terraform.
2. **Database Layer**
Replication Mode: MySQL Master/Slave configuration for high availability.
Databases:
1 Master database.
1 Slave database.
Load Balancer: HAProxy is used to load balance between the databases.
3. **Load Balancers**
Web Servers Load Balancer: Nginx load balancer to distribute traffic across the 3 WordPress web servers.
Database Load Balancer: HAProxy handles database failover between the master and slave databases.
4. **Monitoring and Observability**
Elasticsearch Stack: Used for centralized logging and search capabilities.
Prometheus Exporters: Exporters gather metrics from the system.
Grafana: Visualizes the metrics collected by Prometheus.
Icinga2: Ensures system health and sends alerts in case of issues.
Uptime Kuma: Provides uptime monitoring for services and endpoints.
5. **Cloudflare Tunnel**
The WordPress web servers use Cloudflare Tunnels to securely route traffic through Cloudflare, providing additional layers of security and DDoS protection.
6. **Terraform Automation**
Terraform is used to automate the following:
DNS record management.
Cloudflare tunnel configuration.
