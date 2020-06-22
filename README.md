Pritunl
=======

Pritunl as a Docker container

## Config (env)

- `PRITUNL_DEBUG` must be `true` or `false` - controls the `debug` config key.
- `PRITUNL_BIND_ADDR` must be a valid IP on the host - defaults to `0.0.0.0` - controls the `bind_addr` config key.
- `PRITUNL_MONGODB_URI` URI to mongodb instance, default is starting a local mongodb instance in the container and use that.
- `PRITUNL_LOG_FILE` The log file to log to. Default is `/var/log/pritunl.log`

## Usage

```sh
$ docker run -d -p 27017:27017 -e MONGO_INITDB_DATABASE=pritunl --rm mongo
$ docker build -t pritunl .
$ docker run \
    -d \
    --privileged \
    -e PRITUNL_MONGODB_URI=mongodb://localhost:27017/pritunl \
    -e PRITUNL_LOG_FILE=/var/log/pritunl_journal.log\
    -p 1194:1194/udp \
    -p 1194:1194/tcp \
    -p 80:80/tcp \
    -p 443:443/tcp \
    --rm \
    --name pritunl
    pritunl:latest
```

Initial Username and password:

```sh
$ docker exec -it pritunl sh -c "pritunl default-password"

[undefined][2020-06-22 17:39:30,078][INFO] Getting default administrator password
Administrator default password:
  username: "pritunl"
  password: "7pePSEd4kdG0"
```

Based on [jippi/pritunl](https://github.com/jippi/docker-pritunl)
