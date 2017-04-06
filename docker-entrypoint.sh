/usr/bin/dbus-daemon --system

echo "URL: $DH_URL
AccessKey: $DH_AccessKey
DeviceID: $DH_DeviceID
DeviceName: $DH_DeviceName
DeviceNotifcationsReceive: $DH_DeviceNotifcationsReceive
SendNotificatonQueueCapacity: $DH_SendNotificatonQueueCapacity
LoggingLevel: $DH_LoggingLevel" > /root/deviceconf.yml

sleep $STARTUP_DELAY

$GOPATH/bin/devicehive-cloud -conf=/root/deviceconf.yml &
go run /root/dummy.go
