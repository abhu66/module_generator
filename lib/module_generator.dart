library module_generator;

import 'dart:io';

/// Generate a new GetX module.
///
/// [moduleName] = nama folder module (ex: "home")
/// [routeName]  = nama konstanta route (ex: "HOME")
/// [routePath]  = path route (ex: "/home")
void generateModule(String moduleName, String routeName, String routePath) {
  final capModuleName =
      moduleName[0].toUpperCase() + moduleName.substring(1);

  final folder = Directory("lib/modules/$moduleName");
  folder.createSync(recursive: true);

  // === Controller ===
  File("${folder.path}/${moduleName}_controller.dart").writeAsStringSync('''
import 'package:android/import_all.dart';

class ${capModuleName}Controller extends GetxController {
  // TODO: Implement ${capModuleName}Controller
}
''');

  // === Page ===
  File("${folder.path}/${moduleName}_page.dart").writeAsStringSync('''
import 'package:android/import_all.dart';

class ${capModuleName}Page extends GetView<${capModuleName}Controller> {
  const ${capModuleName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$capModuleName')),
      body: const Center(child: Text('$capModuleName View')),
    );
  }
}
''');

  // === Binding ===
  File("${folder.path}/${moduleName}_binding.dart").writeAsStringSync('''
import 'package:android/import_all.dart';

class ${capModuleName}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${capModuleName}Controller>(() => ${capModuleName}Controller());
  }
}
''');

  // === Index ===
  File("${folder.path}/${moduleName}.dart").writeAsStringSync('''
export '${moduleName}_controller.dart';
export '${moduleName}_binding.dart';
export '${moduleName}_page.dart';
''');

  print("✅ Module '$moduleName' created at ${folder.path}");

  // === Update import_all.dart ===
  final importFile = File("lib/import_all.dart");
  if (importFile.existsSync()) {
    final importContent = importFile.readAsStringSync();
    final exportLine = "export 'modules/$moduleName/$moduleName.dart';"; // ⬅️ perbaikan

    if (!importContent.contains(exportLine)) {
      importFile.writeAsStringSync("$importContent\n$exportLine\n");
      print("✅ Registered in import_all.dart");
    } else {
      print("ℹ️ Already registered in import_all.dart");
    }
  }

  // === Update routes.dart ===
  final routesFile = File("lib/getx/routes.dart");
  if (routesFile.existsSync()) {
    var content = routesFile.readAsStringSync();
    final newRoute = '  static const $routeName = "$routePath";';

    if (!content.contains("static const $routeName")) {
      final updated = content.replaceFirstMapped(
        RegExp(r'sealed class Routes\s*{'),
            (match) => "${match.group(0)}\n$newRoute",
      );
      routesFile.writeAsStringSync(updated);
      print("✅ Route '$routeName' added to routes.dart");
    }
  }

  // === Update pages.dart ===
  final pagesFile = File("lib/getx/pages.dart");
  if (pagesFile.existsSync()) {
    var content = pagesFile.readAsStringSync();
    final getPageEntry = '''
    GetPage(
      name: Routes.$routeName,
      page: () => const ${capModuleName}Page(),
      binding: ${capModuleName}Binding(),
    ),
''';

    if (content.contains("static final pages = [") &&
        !content.contains("${capModuleName}Page")) {
      final updated = content.replaceFirst(
        RegExp(r'static final pages = \['),
        "static final pages = [\n$getPageEntry",
      );
      pagesFile.writeAsStringSync(updated);
      print("✅ Page entry for '$moduleName' added to pages.dart");
    }
  }
}
