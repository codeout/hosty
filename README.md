# Hosty

## Overview

/etc/hosts based tiny reverse proxy.

You may sometimes run a web application on ```http://localhost:3000``` during development, or
sometimes you may configure a local port forward on ```http://localhost:8080``` with SSH to access web server behind firewalls.

Hosty loads your ```/etc/hosts``` and acts as reverse proxies to simplify the URLs.
It allows you to manage mappings of local server name and port on ```/etc/hosts```.

## Installation

```zsh
$ gem install hosty
```

## Usage

Run:

```zsh
sudo hosty
```

If you have lines below in your ```/etc/hosts```:

```
127.0.0.1 internal.example.com internal  # :8080
127.0.0.1 rails  # :3000
```

Hosty accepts ```http://internal.example.com/foo``` locally and proxies it
into ```http://internal.example.com:8080/foo``` for example.


### Use https

You can specify ```tls``` option at the end of each line:

```
127.0.0.1 internal.example.com internal  # :8080 tls
```

Hosty accepts ```http://internal.example.com/foo``` and proxies into ```https://internal.example.com:8080/foo```. Also, you can spacify 'verify_none' to skip server cert verification.

```
127.0.0.1 internal.example.com internal  # :8080 tls verify_none
```

**Note**

The URL scheme in your browser is always 'http'.



## Copyright and License

Copyright (c) 2016 Shintaro Kojima. Code released under the [MIT license](LICENSE).
