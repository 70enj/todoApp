package service

import (
	"fmt"
	"work/todo_api/model"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

//マイグレーションディレクトリ作成予定
func Migrate() {
	db := OpenDB()
	defer CloseDB(db)
	db.Migrator().AutoMigrate(&model.Todo{})
}

//DB設定とオープン
func OpenDB() *gorm.DB {
	const user = "root"
	const pass = ""
	const protocol = ""
	const dbName = "todo"
	const connect = user + ":" + pass + "@" + protocol + "/" + dbName + "?charset=utf8&parseTime=True&loc=Local"

	db, err := gorm.Open(mysql.Open(connect), &gorm.Config{})
	if err != nil {
		fmt.Println(err)
	}
	return db
}

//DBクローズ
func CloseDB(db *gorm.DB) {
	sqlDB, _ := db.DB()
	defer sqlDB.Close()
}
