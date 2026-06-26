In this project the goal is to have a minecraft server that runs locally on my home server.
- The MC server should run in a docker container.
- The MC server should talk to the cloudflared tunnel client.
    - This client should also be in a docker container.
- The user will go to mc.anconalabs.com to play.

- The user will need to download and run the cloudflared client on their local windows computer.
- Along with the minecraft container and the cloudflared container on the server, there should also be a simple nginx webserver that serves up a single page.
    - The page should say "welcome to anconalabs minecraft server!" 
    - The page should have a download button.
    - When the user clicks the button a windows bat file should be downloaded.
        - The bat file should download the cloudflared client for windows.
        - Run the cloudflared.exe file with a connection to mc.anconalabs.com and using localhost:25565.
    - The nginx page should be served from static files in the repo so it can be edited without rebuilding the image.
    - The download button should point at a BAT file that downloads cloudflared for Windows and then starts a local TCP tunnel to mc.anconalabs.com on localhost:25565.
    - If Cloudflare requires separate hostnames, keep the nginx landing page on a normal HTTP hostname and keep mc.anconalabs.com reserved for the Minecraft TCP tunnel.
        
