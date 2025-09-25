# module_generator

[![pub package](https://img.shields.io/pub/v/module_generator.svg)](https://pub.dev/packages/module_generator)

**module_generator** is a simple CLI tool to generate **GetX modules** (Controller, Page, Binding, Routes, and Pages) automatically.  
With just one command, you get a clean folder structure and boilerplate code ✅.

---

## ✨ Features
- Generate a complete **GetX module** (Controller, Page, Binding, Index).
- Automatically updates:
  - `import_all.dart`
  - `getx/routes.dart`
  - `getx/pages.dart`
- Keeps your project structure clean and consistent.
- Usable directly from the terminal.

---

## 📦 Installation

### Global activation
Activate the package globally:

```bash
dart pub global activate module_generator
```

Make sure the pub cache bin directory is in your PATH:

- **Linux / macOS**  
  Add this line to your `~/.bashrc` or `~/.zshrc`:
  ```bash
  export PATH="$PATH":"$HOME/.pub-cache/bin"
  ```

- **Windows (PowerShell)**  
  Add this line to your `$PROFILE`:
  ```powershell
  $env:Path += ";$env:APPDATA\Pub\Cache\bin"
  ```

Verify the installation:
```bash
module_generator --help
```

---

## 🚀 Usage

### Show help
```bash
module_generator --help
```

Output:
```
Usage:
  module_generator -m <module> -r <ROUTE> -p </path> [--package-name my_app]

Options:
  -m, --module         Module name (ex: home)
  -r, --route          Route name (ex: HOME)
  -p, --path           Route path (ex: /home)
  -n, --package-name   Your project package name. If not provided, it will be read from pubspec.yaml
  -h, --help           Show usage information
```

---

### Auto detect package name (default)
Use your `pubspec.yaml` name as package automatically:

```bash
module_generator -m home -r HOME -p /home
```

---

### Override package name (optional)
If you want to specify the package name manually:

```bash
module_generator -m home -r HOME -p /home --package-name=my_custom_app
```

This will generate files with imports like:

```dart
import 'package:my_custom_app/import_all.dart';
```

---

### Example
```bash
module_generator -m home -r HOME -p /home
```

This will create:
```
lib/
 └─ modules/
     └─ home/
         ├─ home_controller.dart
         ├─ home_page.dart
         ├─ home_binding.dart
         └─ home.dart
```

Additionally:
- `lib/import_all.dart` → updated with module export
- `lib/getx/routes.dart` → updated with the new route
- `lib/getx/pages.dart` → updated with a new `GetPage` entry

---

## 📂 Example Output

**home_controller.dart**
```dart
import 'package:<your_package>/import_all.dart';

class HomeController extends GetxController {
  // TODO: Implement HomeController
}
```

**home_page.dart**
```dart
import 'package:<your_package>/import_all.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home View')),
    );
  }
}
```

---

## 🛠️ Development

Clone this repository:
```bash
git clone https://github.com/abhu66/module_generator.git
cd module_generator
```

Activate locally:
```bash
dart pub global activate --source path .
```

Test:
```bash
module_generator -m test -r TEST -p /test
```

---

## 💖 Support the Project

If you find this plugin helpful, consider supporting its development:

- [![Buy Me a Coffee](https://img.shields.io/badge/☕-Buy%20me%20a%20coffee-yellow?logo=buy-me-a-coffee&style=flat-square)](https://buymeacoffee.com/abukhoerula)

Your support is greatly appreciated!

---

## 📄 License

MIT License. See the [LICENSE](LICENSE) file for details.