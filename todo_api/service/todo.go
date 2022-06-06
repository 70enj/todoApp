package service

import (
	"work/todo_api/model"
)

type TodoService struct{}

//Todo新規登録
func (TodoService) SetTodo(todo *model.Todo) error {
	db := OpenDB()
	defer CloseDB(db)
	err := db.Create(&todo).Error
	return err
}

//Todo一覧取得
func (TodoService) GetTodoList() ([]model.Todo, error) {
	todos := make([]model.Todo, 0)
	db := OpenDB()
	defer CloseDB(db)
	err := db.Select("id", "title", "content", "state").Limit(10).Find(&todos).Error
	return todos, err
}

//Todo更新
func (TodoService) UpdateTodo(todo *model.Todo) error {
	db := OpenDB()
	defer CloseDB(db)
	err := db.Select("title", "content", "state", "updated_at").Updates(todo).Error
	return err
}

//Todo削除
func (TodoService) DeleteTodo(todo *model.Todo) error {
	db := OpenDB()
	defer CloseDB(db)
	err := db.Delete(todo).Error
	return err
}
