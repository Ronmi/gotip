#!/bin/bash

uid=$(stat -c '%u' ./src/all.bash)
gid=$(stat -c '%g' ./src/all.bash)

# grab newest code
git clean -fdx
git pull --ff-only

# setup go env
export GOROOT_BOOTSTRAP=$(go env GOROOT)
export GOOS=$(go env GOOS)
export GOARCH=$(go env GOARCH)
export CGO_ENABLED=1

# build
(
    cd src
    ./all.bash
)

unset GOROOT_BOOTSTRAP
# build for all other supported os/arch
for i in $(go tool dist list|grep -vF "${GOOS}/${GOARCH}")
do
    (
	GOOS=$(echo "$i"|cut -d '/' -f 1)
	GOARCH=$(echo "$i"|cut -d '/' -f 2)
	CGO_ENABLED=0
	GOPATH="$(pwd)"
	GOROOT="$(pwd)"

	export GOOS GOARHC CGO_ENABLED GOPATH GOROOT

	echo ''
	echo ''
	echo "# Build standard libs for ${GOOS}/${GOARCH}"
	bin/go install -a -v std
    )
done


# fix permission
chown -R "${uid}:${gid}" .
