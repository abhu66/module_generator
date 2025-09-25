import 'dart:io';
import 'package:args/args.dart';
import 'package:yaml/yaml.dart';
import 'package:module_generator/module_generator.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('module', abbr: 'm', help: 'Module name (ex: home)')
    ..addOption('route', abbr: 'r', help: 'Route name (ex: HOME)')
    ..addOption('path', abbr: 'p', help: 'Route path (ex: /home)')
    ..addOption(
      'package-name',
      abbr: 'n',
      help:
      'Your project package name. If not provided, it will be read from pubspec.yaml',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Show usage information',
    );

  late ArgResults args;
  try {
    args = parser.parse(arguments);
  } catch (e) {
    print('❌ Invalid arguments: $e\n');
    _printUsage(parser);
    exit(64); // EX_USAGE
  }

  if (args['help'] == true) {
    _printUsage(parser);
    exit(0);
  }

  final moduleName = args['module'] as String?;
  final routeName = args['route'] as String?;
  final routePath = args['path'] as String?;
  var packageName = args['package-name'] as String?;

  if (moduleName == null || routeName == null || routePath == null) {
    print('❌ Missing required arguments.\n');
    _printUsage(parser);
    exit(64);
  }

  packageName ??= _readPackageName();

  generateModule(moduleName, routeName, routePath, packageName);
}

void _printUsage(ArgParser parser) {
  print('Usage:');
  print(
      '  module_generator -m <module> -r <ROUTE> -p </path> [--package-name my_app]');
  print('\nOptions:');
  print(parser.usage);
}

String _readPackageName() {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    throw Exception(
        "pubspec.yaml not found. Please provide --package-name manually.");
  }
  final doc = loadYaml(file.readAsStringSync());
  final name = doc['name'];
  if (name == null) {
    throw Exception(
        "No 'name' field found in pubspec.yaml. Please provide --package-name manually.");
  }
  return name.toString();
}