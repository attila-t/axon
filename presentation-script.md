# Start
This is going to be short, 10-20 minutes.

# Intro
* I'm going to introduce you to Flutter, and it's technology stack
* I'm also going to show you a demo app I built using Flutter
* I'm a back-end Java developer, it's fair to say that I hate any front-end related work, yet I quite enjoyed working on this app

# What is Flutter?
Flutter is a UI toolkit for crafting natively compiled applications from a single codebase for:
* mobile: Android and iOS
* desktop: Linux, macOS, Windows
* web

# What is Dart?
Dart is a client-optimized language for developing apps on any platform. It provides the language and runtimes that power Flutter applications.

# The repo
* open a browser
* go to https://github.com/attila-t/axon
* it's public

# Requirement: Android SDK
* I have it installed w/o Android Studio b/c I wanted to use IntelliJ as an IDE; you can use whatever IDE you want
* open terminal no.1
* `cd <android-sdk-dir>`
* list of installed emulators: `emulator -list-avds`
* run an emulator: `emulator @test_avd_29 -no-snapstorage &`

# Apple specific requirements
* Xcode
* iOS simulator
* these work only on macOS
* I don't have a Mac -> I won't showcase this

# Afaik Windows doesn't have any specific requirements
* I run Linux -> I won't showcase this either

# Requirement: Flutter
* I have it installed by cloning its stable branch; you can install it however you want
* open terminal no.2
* `cd <flutter-dir>`
* `git status`
* health: `flutter doctor -v`
* list of available devices: `flutter devices`
* it lists Android emulator(s), your OS dependent desktop, and Chrome as the browser

# The project:
* it's a clone of the above repo
* it's based on an auto-generated Hello World app
* open terminal no.3
* `cd <project-dir>`
* `git status`
* `flutter run` <- will run in the emulator
* play with it
* a bit of background
  * I wrote the core algorithm when I was in high school and that was a long time ago
  * we were learning the Pascal programming language on XT machines with CGA/EGA graphic running DOS at the time (brownie points if you know what these things are)
  * I use this core algorithm whenever I learn/try a programming language <- I never change it
  * if you look at the algorithm you might ask "what the heck is he doing?" <- I still think it wasn't too bad from a teenager

# The code:
* open terminal no.4
* `idea`
* the free community edition is more than enough
* not going to go into coding details, just show how the code is structured and how it looks like
* it was relatively easy to get started as a Java dev, they say JS/TS devs have an even easier time
  * `README.md`
  * `main.dart`: pages, routes (transitions) between pages
  * `shape.dart`: shapes defined by nodes and edges, operations such as rotate and zoom
  * `settings.dart`: state change, i.e. color

Change something, i.e. brightness then go to terminal no.3 then r || R

# Run the app on other devices:
* go to terminal no.3 then q
* stop the running emulator: `adb -s emulator-5554 emu kill`
* `flutter run --device-id chrome`
* start Firefox then go to the copy-pasted the URL from Chrome
* close Chrome, close Firefox
* `flutter run --device-id linux`
* close

# Show the links at the end of the readme

# Questions?
