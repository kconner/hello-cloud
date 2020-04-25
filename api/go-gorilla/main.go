package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func healthCheck(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Health check OK")
}

func main() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/health-check/", healthCheck)
	log.Fatal(http.ListenAndServe(":80", router))
}
