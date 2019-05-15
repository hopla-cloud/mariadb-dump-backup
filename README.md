# mariadb-dump-backup

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Project Description

Simple shell scripts made for backing up MariaDB or MySQL databases.
Works with Acronis Backup cloud (as pre-script) or in standalone.

This repository contains:

1. Configuration script to generate configuration file (init-config.sh)
2. Backup script for MariaDB/MySQL databases (dump.sh) 

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
	- [Generator](#generator)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background


## Install

Get the init script.

```sh
$ curl https://raw.githubusercontent.com/hopla-cloud/mariadb-dump-backup/master/init-config.sh -o init-config.sh
$ chmod +x init-config.sh
```

## Usage

Start the script.

```sh
$ sudo ./init-config.sh
```

## Maintainers

[@hopla.cloud](https://github.com/hopla-cloud).

## Contributing

Feel free to dive in! [Open an issue](https://github.com/hopla-cloud/mariadb-dump-backup/issues/new) or submit PRs.

Hopla.cloud projects follows the [Contributor Covenant](http://contributor-covenant.org/version/1/3/0/) Code of Conduct.

### Contributors

You can find the projects contributors [here](https://github.com/hopla-cloud/mariadb-dump-backup/graphs/contributors).

## License

Licensed under GNU General Public License version 3.
