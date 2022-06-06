package controller

import (
	"net/http"
	"work/todo_api/model"
	"work/todo_api/service"

	"github.com/gin-gonic/gin"
)

func TodoAdd(c *gin.Context) {
	Todo := model.Todo{}
	err := c.Bind(&Todo)
	if err != nil {
		c.String(http.StatusBadRequest, "Bad request")
		return
	}
	TodoService := service.TodoService{}
	err = TodoService.SetTodo(&Todo)
	if err != nil {
		c.String(http.StatusInternalServerError, "Server Error")
		return
	}
	c.JSON(http.StatusCreated, gin.H{
		"status": "ok",
		"data":   Todo.Id,
	})
}

func TodoList(c *gin.Context) {
	TodoService := service.TodoService{}
	TodoLists, err := TodoService.GetTodoList()
	if err != nil {
		c.String(http.StatusInternalServerError, "Server Error")
		return
	}
	c.JSONP(http.StatusOK, gin.H{
		"message": "ok",
		"data":    TodoLists,
	})
}

func TodoUpdate(c *gin.Context) {
	Todo := model.Todo{}
	err := c.Bind(&Todo)
	if err != nil {
		c.String(http.StatusBadRequest, "Bad request")
		return
	}
	TodoService := service.TodoService{}
	err = TodoService.UpdateTodo(&Todo)
	if err != nil {
		c.String(http.StatusInternalServerError, "Server Error")
		return
	}
	c.JSON(http.StatusCreated, gin.H{
		"status": "ok",
	})
}

func TodoDelete(c *gin.Context) {
	Todo := model.Todo{}
	err := c.Bind((&Todo))
	if err != nil {
		c.String(http.StatusBadRequest, "Bad request")
		return
	}
	TodoService := service.TodoService{}
	err = TodoService.DeleteTodo(&Todo)
	if err != nil {
		c.String(http.StatusInternalServerError, "Server Error")
		return
	}
	c.JSON(http.StatusCreated, gin.H{
		"status": "ok",
	})
}
