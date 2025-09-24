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

### Generate a new module
```bash
module_generator <moduleName> <ROUTE_NAME> </routePath>
```

Example:
```bash
module_generator home HOME /home
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
- `lib/import_all.dart` → automatically updated with module export
- `lib/getx/routes.dart` → automatically updated with the new route
- `lib/getx/pages.dart` → automatically updated with a new `GetPage` entry

---

## 📂 Example Output

**home_controller.dart**
```dart
import 'package:android/import_all.dart';

class HomeController extends GetxController {
  // TODO: Implement HomeController
}
```

**home_page.dart**
```dart
import 'package:android/import_all.dart';

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
module_generator test TEST /test
```

---
## Support the Project

If you find this plugin helpful, consider supporting its development:

- [![Buy Me a Coffee](https://img.shields.io/badge/☕-Buy%20me%20a%20coffee-yellow?logo=buy-me-a-coffee&style=flat-square)](https://buymeacoffee.com/abukhoerula)

Your support is greatly appreciated!

## 📄 License

MIT License. See the [LICENSE](LICENSE) file for details.