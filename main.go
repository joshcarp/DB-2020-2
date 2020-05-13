package main

import (
"fmt"
"database/sql"
_ "github.com/go-sql-driver/mysql"
)

func main() {
    fmt.Println("Go MySQL Tutorial")

    // Open up our database connection.
    // I've set up a database on my local machine using phpmyadmin.
    // The database is called testDb
    db, err := sql.Open("mysql", "root:1234@tcp(127.0.0.1:3307)/rugby")

    // if there is an error opening the connection, handle it
    check(err)

    // defer the close till after the main function has finished
    // executing
    defer db.Close()

    q, err := db.Query("SELECT * FROM game;")
    check(err)
    fmt.Println()
    colTypes, err := q.ColumnTypes()
    check(err)
    for _, e := range colTypes{
        fmt.Println(e.Name())
    }
}

func check(err error){
    if err != nil {
        panic(err.Error())
    }
}
