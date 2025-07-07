# 📦 offline_error_logger

[![Pub Version](https://img.shields.io/pub/v/offline_error_logger.svg)](https://pub.dev/packages/offline_error_logger)

A Flutter package for offline-first error logging and automatic Telegram error reporting.  
Designed for apps that work offline and still need robust error tracking.

---

## 🚀 Features

✅ Logs errors to a local `.txt` file (even when offline)  
✅ Sends all stored logs to a Telegram bot when the internet is available  
✅ Provides an easy-to-use public API: `init()`, `write()`, `getAll()`, `flush()`  
✅ Automatically clears the file after successful Telegram delivery  
✅ Collects device info (OS, version, model)

---

## 🧩 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  offline_error_logger: ^1.1.1
