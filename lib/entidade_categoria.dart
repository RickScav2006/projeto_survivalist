import 'package:flutter/material.dart';

class SurvivalCategory {
  final String title;
  final IconData icon;
  final String description;
  final String imagePath;
  final String secondaryTitle; // Segundo título
  final String secondaryDescription; // Segunda descrição
  final String? secondaryTitle2; // Segundo título adicional (opcional)
  final String? secondaryDescription2; // Segunda descrição adicional (opcional)
  final String? secondaryTitle3; // Terceiro título adicional (opcional)
  final String? secondaryDescription3; // Terceira descrição adicional (opcional)
  final String? secondaryTitle4; // Quarto título adicional (opcional)
  final String? secondaryDescription4; // Quarta descrição adicional (opcional)

  SurvivalCategory({
    required this.title,
    required this.icon,
    required this.description,
    required this.imagePath,
    required this.secondaryTitle,
    required this.secondaryDescription,
    this.secondaryTitle2,
    this.secondaryDescription2,
    this.secondaryTitle3,
    this.secondaryDescription3,
    this.secondaryTitle4,
    this.secondaryDescription4,
  });
}