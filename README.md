# squid-for-http-proxy-testing

## How to run.

Change directory into this project.

```
cd /path/to/squid-for-http-proxy-testing/
```

Use [docker-compose] command to build & run.

```
docker-compose build
docker-compose up -d
```

Squid starts listening http proxy port.

* http://127.0.0.1:3128

## How to stop.

```
docker-compose down
```

## Squid access logs.

Check squid container name.

```
docker ps -a

CONTAINER ID  IMAGE                               COMMAND                 CREATED        STATUS        PORTS                   NAMES
f682a76b0179  squid-for-http-proxy-testing_squid  "/bin/sh -c '/bin/sh…"  8 minutes ago  Up 8 minutes  0.0.0.0:3128->3128/tcp  squid-for-http-proxy-testing_squid_1
```

You can see squid access logs as docker container logs.

```
docker logs -f squid-for-http-proxy-testing_squid_1
```

OR

```
docker logs squid-for-http-proxy-testing_squid_1 > squid.log
```

## Configuration.

Edit ``.env`` file.

```
vi .env
```

> Need to restart by ``docker-compose down && docker-compose up -d`` commands.

You can change squid http proxy port to ``8080``.

```
# Squid proxy port.
HTTP_PORT=8080

# Basic authentication.
BASIC_AUTH_COMMENT_OUT=#### <-- comment out basic authentication settings.
BASIC_AUTH_USERNAME=squid
BASIC_AUTH_PASSWORD=password
```

To enable basic authentication by username=``user1`` and password=``pass1``.

```
# Squi proxy port.
HTTP_PORT=3128

# Basic authentication.
BASIC_AUTH_COMMENT_OUT=
BASIC_AUTH_USERNAME=user1
BASIC_AUTH_PASSWORD=pass1
```


[docker-compose]:https://docs.docker.com/compose/
