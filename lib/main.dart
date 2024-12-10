import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/home_screen.dart'; // Certifique-se de que o caminho está correto

void main() {
  runApp(DevicePreview(
    enabled: true, // Ative o DevicePreview. Pode alterar para `false` em produção.
    builder: (context) => const MyApp(), // Passe o seu aplicativo aqui.
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flag Play',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      // Adicione a linha abaixo para habilitar o DevicePreview em tempo de execução.
      builder: DevicePreview.appBuilder,
    );
  }
}
