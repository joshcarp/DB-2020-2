package main

import (
    "fmt"
    _ "github.com/go-sql-driver/mysql"
    "github.com/jmoiron/sqlx"
    "log"
)

func main() {
    fmt.Println("----------")
    defer fmt.Println("----------")

    // Open up our database connection.
    // I've set up a database on my local machine using phpmyadmin.
    // The database is called testDb
    //db, err := sql.Open("mysql", "root:1234@tcp(127.0.0.1:3307)/rugby")
    db, err := sqlx.Open("mysql", "root:1234@tcp(127.0.0.1:3307)/rugby")


    // if there is an error opening the connection, handle it
    check(err)

    // defer the close till after the main function has finished
    // executing
    defer db.Close()
    rows, err := db.Queryx("SELECT * FROM team")
    check(err)
    type Team struct{
        TeamID int `db:"TeamID"`
        TeamName string `db:"TeamName"`
        TeamType string `db:"TeamType"`
        ClubID int `db:"ClubID"`
    }
    var team Team
    for rows.Next() {
        err := rows.StructScan(&team)
        if err != nil {
            log.Fatalln(err)
        }
        fmt.Printf("%#v\n", team)
    }



}

func ScanAndPrint(columns int)[]interface{}{
    var ret []interface{}
    for i:=0; i<columns;i++{
        var str string
        ret = append(ret, &str)
    }
    return ret

}

func check(err error){
    if err != nil {
        panic(err.Error())
    }
}
