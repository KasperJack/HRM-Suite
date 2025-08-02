package initializer


import (
	"log"
	"os"
	"gorm.io/gorm"
	"gorm.io/driver/postgres"

)

var DB *gorm.DB

func ConnectToDB(){
	var err error
	dsn := os.Getenv("DSN")
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}

	DB = db
}