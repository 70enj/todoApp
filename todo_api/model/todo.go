package model

import (
	"time"

	"gorm.io/gorm"
)

type Todo struct {
	Id        int64  `gorm:"primaryKey;autoincrement" type:"int(64)" form:"id" json:"id"`
	Title     string `gorm:"type:varchar(40)" json:"title" form:"title"`
	Content   string `gorm:"type:TEXT" json:"content" form:"content"`
	State     int16  `gorm:"type int(16)" json:"state" form:"state"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt
}
