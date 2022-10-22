# axon

A Flutter Demo.

## Note

Some details in this readme might be Linux specific.

## Install Android SDK _without_ Android Studio

1. [Download](https://developer.android.com/studio#command-tools) Command Line Tools
2. Unpack it somewhere.
3. Configure it according to what "!!UPDATE!!" says in this [SO answer](https://stackoverflow.com/a/61176718/1782997)
4. Additional configuration:
   ```bash
   export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
   export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
   ```
5. Follow the steps from no.11 as described [here](https://dev.to/andreisfedotov/how-to-install-android-emulator-without-installing-android-studio-3lce)
6. List available emulators:
   ```bash
   [cd <android-sdk-dir>/emulator]
   emulator -list-avds
   ```
7. Run an emulator:
   ```bash
   [cd <android-sdk-dir>/emulator]
   emulator @test_avd_29 -no-snapstorage &
   ```
8. Connect to a running emulator:
   ```bash
   telnet localhost 5554
   ```
9. Stop a running emulator:
   ```bash
   [cd <android-sdk-dir>/platform-tools]
   adb -s emulator-5554 emu kill
   ```

## Install Flutter

1. Follow the [instructions](https://docs.flutter.dev/get-started/install/linux)
2. Ignore complaints from `flutter doctor -v`:
   * Android license status unknown
   * Android Studio (not installed)
3. List available devices:
   ```bash
   [cd <flutter-dir>]
   flutter devices
   ```
4. Run the demo on a device:
   ```bash
   cd <project-dir>
   flutter run [--device-id linux|chrome|emulator-5554]
   ```
5. The URL to a debugger & profiler on Android SDK is printed out to the standard output.

## Install IntelliJ IDEA

1. [Download](https://www.jetbrains.com/idea/download/#section=linux). The Community Edition should be more than enough.
2. Unpack it somewhere.

## Resources

* [Presentation script](./presentation-script.md)
* The [Flutter](https://flutter.dev) framework
* The [Dart](https://dart.dev) language
* [Cross-platform app development Frameworks in 2022](https://solguruz.com/blog/cross-platform-app-development-frameworks/)
* [Flutter vs. React Native](https://www.youtube.com/watch?v=X8ipUgXH6jw)
