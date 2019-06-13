import 'package:blockpass/routes.dart';
import 'package:blockpass/data/db/db.dart';
import 'package:flutter/material.dart';

void main() async {
  await db.open();
  runApp(Routes());
} 
