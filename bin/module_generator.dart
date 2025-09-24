import 'package:module_generator/module_generator.dart';

void main(List<String> args) {
  if (args.length < 3) {
    print("Usage: module_generator moduleName routeName routePath");
    return;
  }

  final moduleName = args[0];
  final routeName = args[1];
  final routePath = args[2];

  generateModule(moduleName, routeName, routePath);
}