# :joy: expand-emoji

[![Expand-Emoji CI/CD](https://github.com/Cynnexis/expand-emoji/actions/workflows/main.yml/badge.svg)](https://github.com/Cynnexis/expand-emoji/actions/workflows/main.yml)

expand-emoji is a program that replaces all emoji shortcodes in the given files to their respective emoji characters.

## :dart: Goals

This program is only an interface for the [kyokomi's emoji](https://github.com/kyokomi/emoji) library.

## :electric_plug: Getting Started

The following instructions will get you a copy of the source code, and help you execute it.

### :package: Requirements

This project requires [Go][golang].

### :hammer_and_pick: Installation

The first thing to do is to download the project, either by [downloading the ZIP file][project-zip] and extract it somewhere in your machine, or by cloning the project with `git clone https://github.com/Cynnexis/expand-emoji.git`.

The following steps will assume that the current directory is the project root:

1. `go mod tidy`
2. `go build`

You will find a `expand-emoji` binary at the root of your project.

### :whale: Using Docker

You can build a Docker image to use `expand-emoji`.

To build the docker image, enter the following command:

```bash
make build-docker
```

Finally, use the image with the following command:

```bash
docker run -d \
	--name=expand-emoji \
	-v "/path/to/my/folder/file.txt:/go/file.txt" \
	cynnexis/expand-emoji \
	/go/file.txt
```

## :building_construction: Build With

* [Go][golang]
* [kyokomi's emoji](https://github.com/kyokomi/emoji) library

## :handshake: Contributing

To contribute to this project, please read our [`CONTRIBUTING.md`][contributing] file.

We also have a [code of conduct][code-of-conduct] to help create a welcoming and friendly environment.

## :writing_hand: Authors

Please see the [`CONTRIBUTORS.md`][contributors] file.

## :page_facing_up: License

This project is under the GNU Affero General Public License v3. Please see the [LICENSE][license] file for more detail (it's a really fascinating story written in there!).

[golang]: https://go.dev/
[cynnexis]: https://github.com/Cynnexis
[contributing]: CONTRIBUTING.md
[contributors]: CONTRIBUTORS.md
[code-of-conduct]: CODE_OF_CONDUCT.md
[license]: LICENSE
[project-zip]: https://github.com/Cynnexis/expand-emoji/archive/main.zip