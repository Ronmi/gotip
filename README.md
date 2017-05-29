Build newest Go (linux/amd64) without installing Go first.

# CAUTION

It will pull latest Go source code automatically.

You should modify `build.sh` to fit your need. e.g.: change `GOOS` and `GOARCH` to build for your Mac.

# How to Install this tool

```sh
$ git clone https://github.com/Ronmi/gotip
$ cd gotip
$ git clone https://github.com/golang/go go
```

You have to install `docker-ce` and `docker-compose` by yourself.

# How to use this tool

```sh
$ docker-compose up
# or add -d to run in background
$ docker-compose up -d
```

# License

WTFPL
