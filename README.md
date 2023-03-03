# docker-autoremove-torrents

Image for the PyPi module autoremove-torrents. 



> This program can help you to remove your torrents. Now you don’t need
> to worry about your disk space - according to your strategies, the
> program will check each torrent if it satisfies the remove condition;
> If so, delete it automatically.
> 
> This program supports qBittorrent/Transmission/μTorrent.

https://pypi.org/project/autoremove-torrents/

## Usage

1. Clone the repository. e.g

```shell
git clone https://github.com/ludoux/docker-autoremove-torrents.git
```

2. Create a docker image
```shell
cd docker-autoremove-torrents
docker build -t autoremove-torrents:latest .
```

3. Deploy your container using the image
Here are some example snippets to help create your container

**docker-cli**

```shell 
docker run autoremove-torrents:latest \
-v /opt/autoremove-torrents/config:/app \
-v /opt/autoremove-torrents/logs/autoremove-torrents.log:/var/log/autoremove-torrents.log \
-e PUID=1000 \
-e PGID=1000 \
-e TZ=Asia/Shanghai \
-e OPTS=customoptions \
--name autoremove-torrents
```

**docker-compose**

```shell
---
version: '3.7'
services:
    autoremove-torrents:
        container_name: autoremove-torrents
        volumes:
            - '/opt/autoremove-torrents/config:/app'
            - '/opt/autoremove-torrents/logs/autoremove-torrents.log:/var/log/autoremove-torrents.log'
        environment:
             - PUID=1000
             - PGID=1000
             - TZ=Asia/Shanghai
             - OPTS=customoptions
        image: 'autoremove-torrents:latest'
        networks:
            - default
        restart: unless-stopped
networks:
 default:
   driver: bridge
   external: true
```
Run: `docker-compose up -d`

## Paramaters

OPTS can take the following arguments:

<table border="1" class="docutils">
<colgroup>
<col width="33%">
<col width="33%">
<col width="33%">
</colgroup>
<thead valign="bottom">
<tr class="row-odd"><th class="head">Arugments</th>
<th class="head">Argument Abbreviations</th>
<th class="head">Description</th>
</tr>
</thead>
<tbody valign="top">
<tr class="row-even"><td><cite>–view</cite></td>
<td><cite>-v</cite></td>
<td>Run and see which torrents will be removed, but don’t really remove them.</td>
</tr>
<tr class="row-odd"><td><cite>–conf</cite></td>
<td><cite>-c</cite></td>
<td>Specify the path of the configuration file.</td>
</tr>
<tr class="row-even"><td><cite>–task</cite></td>
<td><cite>-t</cite></td>
<td>Run a specific task only. The argument value is the task name.</td>
</tr>
<tr class="row-odd"><td><cite>–log</cite></td>
<td><cite>-l</cite></td>
<td>Sepcify the path of the log file.</td>
</tr>
</tbody>
</table>

The file config.yml contains all the configuration needed to make autoremove-torrents work. Just bind the file to /app/config.yml and you are good to go.
