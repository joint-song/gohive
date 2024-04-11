package main

import (
	"log"

	"github.com/joint-song/gohive"
	"github.com/joint-song/gohive/hive_metastore"
)

func main() {
	configuration := gohive.NewMetastoreConnectConfiguration()
	connection, err := gohive.ConnectToMetastore("hm.example.com", 9083, "KERBEROS", configuration)
	if err != nil {
		log.Fatal(err)
	}
	database := hive_metastore.Database{
		Name:        "my_new_database",
		LocationUri: "/"}
	err = connection.Client.CreateDatabase(&database)
	if err != nil {
		log.Fatal(err)
	}
	databases, err := connection.Client.GetAllDatabases()
	if err != nil {
		log.Fatal(err)
	}
	log.Println("databases ", databases)
	connection.Close()
}
