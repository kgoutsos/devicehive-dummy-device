package main

import (
	"log"
	"os"
	"time"

	// DBus helper library from DeviceHive
	// Not an absolute requirement, it just makes the use of DBus from Go easier
	"github.com/devicehive/IoT-framework/godbus-helpers/cloud"
)

func main() {
	cloud, err := cloud.NewDbusForComDevicehiveCloud()
	if err != nil {
		log.Panic(err)
	}

	h, _ := os.Hostname()

	for {
		if err != nil {
			log.Panic(err)
		}

		cloud.SendNotification("testNotification", map[string]interface{}{
			"this is a name": "and this is a value",
			"device name": h,
		}, 1)

		log.Printf("Notification sent")

		time.Sleep(time.Second)
	}
}
