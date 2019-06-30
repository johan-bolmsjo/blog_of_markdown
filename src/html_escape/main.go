package main

import (
	"fmt"
	"html"
	"os"
)

func main() {
	for _, s := range os.Args[1:] {
		fmt.Println(html.EscapeString(s))
	}
}
