# kclogin_flutter

A Flutter plugin for integrating **KingsChat login** functionality into your Flutter apps.  
Currently supports **Android only**, providing easy-to-use APIs to authenticate users via KingsChat.

[![pub package](https://img.shields.io/pub/v/kclogin_flutter)](https://pub.dev/packages/kclogin_flutter)
[![License](https://img.shields.io/badge/license-Apache_2.0-blue)](LICENSE)

---

## Features

- Sign in with KingsChat accounts  
- Android support only (iOS coming soon)  
- Simple and easy-to-use API  
- Fully compatible with Flutter 3.x+  
- Null-safety enabled  

---

## Installation

### Add Dependency

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  kclogin_flutter: ^1.0.0
Then run:

flutter pub get
Android Setup
In your AndroidManifest.xml (inside <application>), add your KingsChat App ID:

<meta-data
    android:name="com.kingschat.sdk.ApplicationId"
    android:value="YOUR_APPLICATION_ID" />
Replace YOUR_APPLICATION_ID with your actual KingsChat application ID.

