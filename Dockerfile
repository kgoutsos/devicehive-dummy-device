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

ADD dummy.go /root/
ADD docker-entrypoint.sh /root/

ENV DH_URL http://devicehive-server:8080/api/rest
ENV DH_AccessKey eyJhbGciOiJIUzI1NiJ9.eyJwYXlsb2FkIjp7InVzZXJJZCI6MSwiYWN0aW9ucyI6WyIqIl0sIm5ldHdvcmtJZHMiOlsiKiJdLCJkZXZpY2VHdWlkcyI6WyIqIl0sImV4cGlyYXRpb24iOjE0OTcwMTg5NDgyODcsInRva2VuVHlwZSI6IkFDQ0VTUyJ9fQ.BQgno2Tz233VG530JUK6zlCVrAdeny1IvKQRswd6hVw
ENV DH_DeviceID sample-device
ENV DH_DeviceName sample-device
ENV DH_DeviceNotifcationsReceive REST
ENV DH_SendNotificatonQueueCapacity 2048
ENV DH_LoggingLevel info
ENV STARTUP_DELAY 120

ENTRYPOINT /root/docker-entrypoint.sh
