package main

import (
	"work/todo_api/controller"
	"work/todo_api/middleware"
	"work/todo_api/service"

	"github.com/gin-gonic/gin"
)

func main() {
	service.Migrate()
	engine := gin.Default()
	// ミドルウェア
	engine.Use(middleware.WriteLog)
	// CRUD
	todoEngine := engine.Group("/todo")
	{
		todoEngine.POST("/add", controller.TodoAdd)
		todoEngine.GET("/list", controller.TodoList)
		todoEngine.PUT("/update", controller.TodoUpdate)
		todoEngine.DELETE("/delete", controller.TodoDelete)
	}
	engine.Run()
}
