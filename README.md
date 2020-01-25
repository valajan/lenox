# Lenox
A simple static site generator written in [Dart](https://dart.dev/)

## How to start

**Clone** the repository
```
git clone https://github.com/valajan/lenox.git
cd lenox
```

**Start** Lenox with
```
dart main.dart
```
**Build** the static website with
```
pub run build.dart --js (optional) --theme=bulma (choose a theme)
```

**Launch** webdev server with
Webdev package can only works if the build.yaml file is present.

You can configure it with your own desire !

Optionnaly you can create a web folder and delete the unnecessary build.yaml file.

```
webdev serve build:3000 (choose your port)
```