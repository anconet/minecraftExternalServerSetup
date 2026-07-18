# minecraftExternalServerSetup

A repo for depoly an MC setup on my local hypervisor.

```mermaid
flowchart LR
	subgraph Compose[docker-compose stack]
		CF["cloudflared container<br/>image: cloudflared-with-nc:latest"]
		MC["minecraft container<br/>image: itzg/minecraft-server:latest"]
		WEB["minecraft-web container<br/>image: nginx:alpine"]
	end

	CF -->|"TCP traffic to<br/>mc.anconalabs.com"| MC
	CLOUDFLARE[(Cloudflare Tunnel)] -->|feeds tunnel traffic to| CF
	CF -->|"HTTP traffic to<br/>mc-setup.anconalabs.com"| WEB

	MC -->|mounts ./minecraft-data:/data| MC_DATA[(minecraft-data)]
	WEB -->|mounts ./web/*| WEB_FILES[(web content/config)]
```

## Useful MC commands
```bash

docker exec -it minecraft ...
	whitelist on
	add <user>
	gamemode creative <user>
	gamemode survival <user>
	spawnpoint <user>
	tp <MeToUser> 
	tp <user> <toMe>
```