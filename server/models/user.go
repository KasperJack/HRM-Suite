package models

import (
  "time"
 //"gorm.io/gorm"
 ) 



type CreateUserRequest struct {
    Role      string         `json:"role" binding:"required"`
    Email     string         `json:"email" binding:"required,email"`
    Password  string         `json:"password" binding:"required,min=8"`
    FullName  string         `json:"full_name" binding:"required"`
    Gender    string         `json:"gender" binding:"required"`
    NidNumber string         `json:"nid_number" binding:"required"`
    Location  string         `json:"location" binding:"required"`
    BirthDate time.Time      `json:"birth_date" binding:"required"`
    Phone     string         `json:"phone" binding:"required"`
}





func (CreateUserRequest) TableName() string {
	return "users"
}









/*
type CreateUserRequest struct {
    //ID        uint           `gorm:"primaryKey" json:"id"`
    Role      string         `json:"role" binding:"required"`
	//IsActive  bool
    Email     string         `json:"email" binding:"required,email"`
    Password  string         `json:"password" binding:"required,min=8"`
    FullName  string         `json:"full_name" binding:"required"`
    Gender    string         `json:"gender" binding:"required"`
    NidNumber string         `json:"nid_number" binding:"required"`
    Location  string         `json:"location" binding:"required"`
    BirthDate time.Time      `json:"birth_date" binding:"required"`
    Phone     string         `json:"phone" binding:"required"`

    //CreatedAt time.Time      `json:"created_at"`
    //UpdatedAt time.Time      `json:"updated_at"`
    //DeletedAt gorm.DeletedAt `gorm:"index" json:"-"`
}*/

















/*type User struct {
	ID        uint      `gorm:"column:user_id" json:"id"`
	Username  string    `gorm:"column:user_name" json:"username"`
	Email     string    `gorm:"column:email_address" json:"email"`
	CreatedAt time.Time `gorm:"column:created_timestamp" json:"created_at"`
}*/