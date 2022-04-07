package main

import (
	"log"
	"os"

	"github.com/kyokomi/emoji/v2"
)

// The application version.
const APP_VERSION string = "1.0.0"

// Default logger for the program
var defaultLog = log.New(os.Stdout, "", 0)

// Print the help message about the application to the console.
//
// The argument `stdout` indicates if the message should be write to the
// standard output (`true`) or the standard err (`false`).
func print_help(stdout bool) {
	var l = log.New(os.Stdout, "", 0)
	if !stdout {
		l = log.New(os.Stderr, "", 0)
	}

	l.Printf("%s\nReplace all emoji shortcodes in the given files to their respective emoji characters, in-place.\n\nusage: %s [-h/--help] [--verbose] FILE...\n\nArguments:\n\t-h/--help  - Print this message and quits.\n\t--version  - Print the version and quits.\n", os.Args[0], os.Args[0])
}

// Main function.
func main() {
	// Parse arguments
	if len(os.Args[1:]) == 1 {
		if os.Args[1] == "--help" || os.Args[1] == "-h" {
			print_help(true)
			os.Exit(0)
		} else if os.Args[1] == "--version" {
			defaultLog.Printf("%s version %s", os.Args[0], APP_VERSION)
			os.Exit(0)
		}
	}

	// Parse arguments
	for _, file_name := range os.Args[1:] {
		defaultLog.Printf("Parsing \"%s\"...", file_name)
		// Open file to read stat
		fd, err := os.Open(file_name)
		if err != nil {
			defaultLog.Fatal(err)
			os.Exit(1)
		}
		fd_stat, err := fd.Stat()
		if err != nil {
			defaultLog.Fatal(err)
			os.Exit(2)
		}
		fd.Close()

		// Read file
		content, err := os.ReadFile(file_name)
		if err != nil {
			defaultLog.Fatal(err)
			os.Exit(3)
		}

		// Expand emoji shortcodes into actual emoji
		var expanded_content = emoji.Sprint(string(content))

		// Write file
		err = os.WriteFile(file_name, []byte(expanded_content), fd_stat.Mode())
		if err != nil {
			defaultLog.Fatal(err)
			os.Exit(4)
		}
	}
}
