# minecraftExternalServerSetup

A repo for depoly an MC setup on my local hypervisor.

```mermaid
flowchart LR
	subgraph Compose[docker-compose stack]
		CF[cloudflared container\nimage: cloudflared-with-nc:latest]
		MC[minecraft container\nimage: itzg/minecraft-server:latest]
		WEB[minecraft-web container\nimage: nginx:alpine]
	end

	CF -->|TCP traffic to\n mc.anconalabs.com| MC
	CLOUDFLARE[(Cloudflare Tunnel)] -->|feeds tunnel traffic to| CF
	CF -->|HTTP trafic to\n mc-setup.anconalabs.com| WEB

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