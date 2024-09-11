import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

List<AppColorScheme> colorScheme = [
  AppColorScheme(
    name: 'blue',
    color: const Color.fromARGB(255, 59, 130, 246),
    light: const ShadBlueColorScheme.light(),
    dark: const ShadBlueColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'gray',
    color: const Color.fromARGB(255, 107, 114, 128),
    light: const ShadGrayColorScheme.light(),
    dark: const ShadGrayColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'green',
    color: const Color.fromARGB(255, 34, 197, 94),
    light: const ShadGreenColorScheme.light(),
    dark: const ShadGreenColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'neutral',
    color: const Color.fromARGB(255, 115, 115, 115),
    light: const ShadNeutralColorScheme.light(),
    dark: const ShadNeutralColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'orange',
    color: const Color.fromARGB(255, 249, 115, 22),
    light: const ShadOrangeColorScheme.light(),
    dark: const ShadOrangeColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'red',
    color: const Color.fromARGB(255, 239, 68, 68),
    light: const ShadRedColorScheme.light(),
    dark: const ShadRedColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'rose',
    color: const Color.fromARGB(255, 244, 63, 94),
    light: const ShadRoseColorScheme.light(),
    dark: const ShadRoseColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'slate',
    color: const Color.fromARGB(255, 100, 116, 139),
    light: const ShadSlateColorScheme.light(),
    dark: const ShadSlateColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'stone',
    color: const Color.fromARGB(255, 120, 113, 108),
    light: const ShadStoneColorScheme.light(),
    dark: const ShadStoneColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'violet',
    color: const Color.fromARGB(255, 139, 92, 246),
    light: const ShadVioletColorScheme.light(),
    dark: const ShadVioletColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'yellow',
    color: const Color.fromARGB(255, 234, 179, 8),
    light: const ShadYellowColorScheme.light(),
    dark: const ShadYellowColorScheme.dark(),
  ),
  AppColorScheme(
    name: 'zinc',
    color: const Color.fromARGB(255, 113, 113, 122),
    light: const ShadZincColorScheme.light(),
    dark: const ShadZincColorScheme.dark(),
  ),
];

class AppColorScheme {
  String name;
  Color color;
  ShadColorScheme light;
  ShadColorScheme dark;

  AppColorScheme(
      {required this.name,
      required this.color,
      required this.light,
      required this.dark});
}
