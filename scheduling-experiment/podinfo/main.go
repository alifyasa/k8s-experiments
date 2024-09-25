package main

import (
	"encoding/json"
	"net/http"
	"os"
	"strings"
	"time"
)

type ResponseData struct {
	RequestedPath string            `json:"requested_path"`
	CurrentTime   string            `json:"current_time"`
	EnvVariables  map[string]string `json:"env_variables"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	data := ResponseData{
		RequestedPath: r.URL.Path,
		CurrentTime:   time.Now().UTC().Format(time.RFC3339) + "Z",
		EnvVariables:  make(map[string]string),
	}

	for _, e := range os.Environ() {
		parts := strings.SplitN(e, "=", 2)
		if len(parts) == 2 {
			data.EnvVariables[parts[0]] = parts[1]
		}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	responseJSON, err := json.MarshalIndent(data, "", "  ")
	if err != nil {
		http.Error(w, "Error encoding JSON", http.StatusInternalServerError)
		return
	}
	w.Write(responseJSON)
}

func main() {
	http.HandleFunc("/", handler)
	address := "0.0.0.0:80"
	println("Serving on port", address)
	if err := http.ListenAndServe(address, nil); err != nil {
		println("Error starting server:", err)
	}
}
