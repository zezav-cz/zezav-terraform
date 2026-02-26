package main

import (
	"context"
	"dagger/terafrom/internal/dagger"
	"fmt"
)

type Terafrom struct {
	Source *dagger.Directory
	Env    *dagger.Container
}

func New(
	// The source directory to be used in the module's functions
	// +defaultPath="."
	source *dagger.Directory,
) *Terafrom {
	return &Terafrom{
		Source: source,
		Env:    getContainer(source),
	}
}

// Runs editorconfig-checker on the source code
// +check
func (m *Terafrom) EditorConfigChecker(ctx context.Context) error {
	_, err := m.Env.
		WithExec([]string{"editorconfig-checker"}).
		Sync(ctx)
	return err
}

// Runs FormatCheck on the source code
// +check
func (m *Terafrom) FormatCheck(ctx context.Context) error {
	_, err := m.Env.
		WithExec([]string{"tofu", "fmt", "-check", "-diff", "-recursive", "."}).
		Sync(ctx)
	return err
}

// ----- Helper funtions -----
func getContainer(source *dagger.Directory) *dagger.Container {
	const (
		tofuVersion = "1.11.5"
		ecVersion   = "3.6.1"
		platform    = "linux"
		arch        = "amd64"
	)
	tofuUrl := fmt.Sprintf("https://github.com/opentofu/opentofu/releases/download/v%s/tofu_%s_%s.apk", tofuVersion, tofuVersion, arch)
	tofuApk := dag.HTTP(tofuUrl)
	ecUrl := fmt.Sprintf("https://github.com/editorconfig-checker/editorconfig-checker/releases/download/v%s/editorconfig-checker_%s_%s_%s.apk", ecVersion, ecVersion, platform, arch)
	ecApk := dag.HTTP(ecUrl)
	return dag.Container().
		From("alpine:3").
		WithExec([]string{"apk", "add", "--no-cache",
			"yq", "jq", "git", "wget", "curl", "openssh-client", "ca-certificates",
		}).
		WithFile("/tmp/tofu.apk", tofuApk).
		WithFile("/tmp/editorconfig-checker.apk", ecApk).
		WithExec([]string{"apk", "add", "--no-cache", "--allow-untrusted", "/tmp/tofu.apk"}).
		WithExec([]string{"apk", "add", "--allow-untrusted", "--no-cache", "/tmp/editorconfig-checker.apk"}).
		WithExec([]string{"rm", "/tmp/tofu.apk"}).
		WithExec([]string{"rm", "/tmp/editorconfig-checker.apk"}).
		WithDirectory("/src", source).
		WithWorkdir("/src")
}
