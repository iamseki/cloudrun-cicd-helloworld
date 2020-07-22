package main

import (
	"net/http"
	"os"
)

type helloHandler struct {
	html string
}

func (h *helloHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte(h.html))
}

func main() {

	http.Handle("/", &helloHandler{html: `
		<h1>
			Hello World !
		</h1>
	`})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	http.ListenAndServe(":"+port, nil)
}
