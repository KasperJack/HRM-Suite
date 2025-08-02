package main

import (
	"github.com/gin-gonic/gin"
	"pgtest/initializer"
	"pgtest/routes"

)



func init(){

	initializer.LoadEnvVariables()
	initializer.ConnectToDB()
}




func main() {


	r := gin.Default()

	routes.RegisterUserRoutes(r)

	r.Run() // default is :8080
}
