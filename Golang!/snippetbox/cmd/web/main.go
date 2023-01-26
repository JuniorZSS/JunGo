package main

import (
	"database/sql"
	"flag"
	"github.com/golangcollege/sessions"
	"html/template" // Новый импорт
	"log"
	"net/http"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"golang.com/snippetbox/pkg/models/mysql"
)

// Добавляем поле templateCache в структуру зависимостей. Это позволит
// получить доступ к кэшу во всех обработчиках.
type application struct {
	errorLog      *log.Logger
	infoLog       *log.Logger
	session       *sessions.Session
	snippets      *mysql.SnippetModel
	users         *mysql.UserModel
	templateCache map[string]*template.Template
}

func main() {
	addr := flag.String("addr", ":4000", "Сетевой адрес веб-сервера")
	dsn := flag.String("dsn", "root:root@tcp(127.0.0.1:3306)/snippetbox?parseTime=true", "Local instance MySQL80") //"mysql", "web:pass@/snippetbox?parseTime=true"
	secret := flag.String("secret", "s6Ndh+pPbnzHbS*+9Pk8qGWhTzbpa@ge", "Secret key")

	flag.Parse()

	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stderr, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	db, err := openDB(*dsn)
	if err != nil {
		errorLog.Fatal(err)
	}
	defer db.Close()

	templateCache, err := newTemplateCache("./ui/html/")
	if err != nil {
		errorLog.Fatal(err)
	}
	// Инициализируем новый кэш шаблона...

	// Тут заканчивается авторизация
	// И добавляем его в зависимостях нашего
	// веб-приложения.
	session := sessions.New([]byte(*secret))
	session.Lifetime = 12 * time.Hour

	app := &application{
		errorLog:      errorLog,
		infoLog:       infoLog,
		session:       session,
		snippets:      &mysql.SnippetModel{DB: db},
		users:         &mysql.UserModel{DB: db},
		templateCache: templateCache,
	}

	srv := &http.Server{
		Addr:           *addr,
		ErrorLog:       errorLog,
		Handler:        app.routes(),
		IdleTimeout:    time.Minute,
		ReadTimeout:    5 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 524288,
	}

	infoLog.Printf("Запуск сервера на http://127.0.0.1%s", *addr)
	err = srv.ListenAndServe()
	errorLog.Fatal(err)
}

func openDB(dsn string) (*sql.DB, error) {
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return nil, err
	}
	if err = db.Ping(); err != nil {
		return nil, err
	}
	return db, nil
}
