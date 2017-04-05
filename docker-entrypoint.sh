service dbus start
$GOPATH/bin/devicehive-cloud -conf=/root/deviceconf.yml &
go run /root/dummy.go
