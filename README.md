<h1 align=center>Dockette / Web</h1>

<p align=center>
   🐳 Ready-to-use docker images for websites (nginx, PHP 7.2/7.3/7.4 + FPM, supervisor).
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://hub.docker.com/r/dockette/web/"><img src="https://badgen.net/docker/pulls/dockette/web"></a>
  <a href="https://bit.ly/ctteg"><img src="https://badgen.net/badge/support/gitter/cyan"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
</p>

![](https://github.com/dockette/web/blob/master/screenshot.png "It works")

## Usage

| Image                 | Distro | PHP |
|-----------------------|--------|-----|
| `dockette/web:php-81` | Buster | 8.1 |
| `dockette/web:php-80` | Buster | 8.0 |
| `dockette/web:php-74` | Buster | 7.4 |
| `dockette/web:php-73` | Buster | 7.3 |
| `dockette/web:php-72` | Buster | 7.2 |

You can easily start your Docker container with following command.

```
docker run \
	-it \
	--rm \
	--name www \
	-p 80:80 \
	dockette/web:php80
```

## Development

See [how to contribute](https://contributte.org/contributing.html) to this package.

This package is currently maintaining by these authors.

<a href="https://github.com/f3l1x">
    <img width="80" height="80" src="https://avatars2.githubusercontent.com/u/538058?v=3&s=80">
</a>

-----

Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Also thank you for using this package.
