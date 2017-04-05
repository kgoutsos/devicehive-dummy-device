FROM golang

MAINTAINER kgoutsos

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim dbus && \
    rm -rf /var/lib/apt/lists/*

RUN ! ssh -o "StrictHostKeyChecking no" github.com && \
    ! go get github.com/devicehive/IoT-framework/devicehive-cloud && \
    go get github.com/devicehive/IoT-framework/devicehive-cloud && \
    cd $GOPATH/src/github.com/devicehive/IoT-framework/devicehive-cloud && \
    go install

ADD com.devicehive.cloud.conf /etc/dbus-1/system.d/

ADD deviceconf.yml /root/
ADD dummy.go /root/
ADD docker-entrypoint.sh /root/

ENTRYPOINT /root/docker-entrypoint.sh
