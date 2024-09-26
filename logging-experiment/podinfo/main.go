package main

import (
	"encoding/json"
	"fmt"
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

// Function to create the response data
func getResponseData(r *http.Request) ResponseData {
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

	return data
}

func handler(w http.ResponseWriter, r *http.Request) {
	data := getResponseData(r)

	// Write headers and data
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	responseJSON, err := json.MarshalIndent(data, "", "  ")
	if err != nil {
		http.Error(w, "Error encoding JSON", http.StatusInternalServerError)
		return
	}
	w.Write(responseJSON)

	// Log the data every 5 seconds
	go logEveryFiveSeconds(data)
}

func logEveryFiveSeconds(data ResponseData) {
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		logData, err := json.MarshalIndent(data, "", "  ")
		if err != nil {
			fmt.Println("Error logging data:", err)
			continue
		}
		fmt.Println("Logging every 5 seconds:", string(logData))
	}
}

func main() {
	http.HandleFunc("/", handler)
	address := "0.0.0.0:80"
	fmt.Println("Serving on port", address)
	if err := http.ListenAndServe(address, nil); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
