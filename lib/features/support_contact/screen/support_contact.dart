import 'package:fake_store/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soporte y Contacto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "¿Tienes algún problema o consulta?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const Text("Puedes contactarnos a través de:"),
            const SizedBox(height: 12),

            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text("soporte@fakestore.com"),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("+51 999 123 456"),
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text("www.fake_store.com"),
            ),

            const SizedBox(height: 24),
            const Text("También puedes enviarnos un mensaje:"),

            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: "Asunto",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Mensaje",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Mensaje enviado")),
                );
              },
              child: const Text("Enviarr", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
