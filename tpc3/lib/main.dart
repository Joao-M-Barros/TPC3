import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Prescription',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PrescriptionPage(),
    );
  }
}

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final _medicationController = TextEditingController();
  final _dosageController = TextEditingController();
  final _scheduleController = TextEditingController();

  List<Map<String, String>> _prescriptions = [];

  void _savePrescription() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _prescriptions.add({
          'medication': _medicationController.text,
          'dosage': _dosageController.text,
          'schedule': _scheduleController.text,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prescription saved to patient profile')),
      );
      _medicationController.clear();
      _dosageController.clear();
      _scheduleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Prescription'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _medicationController,
                    key: const Key('medication_field'),
                    decoration: const InputDecoration(labelText: 'Medication Name'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _dosageController,
                    key: const Key('dosage_field'),
                    decoration: const InputDecoration(labelText: 'Dosage (e.g., 500mg)'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _scheduleController,
                    key: const Key('schedule_field'),
                    decoration: const InputDecoration(labelText: 'Schedule (e.g., Every 8 hours)'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    key: const Key('save_button'),
                    onPressed: _savePrescription,
                    child: const Text('Save Prescription'),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),
            const Text(
              'Patient Schedule View',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _prescriptions.length,
                itemBuilder: (context, index) {
                  final p = _prescriptions[index];
                  return ListTile(
                    key: Key('prescription_item_$index'),
                    title: Text('${p['medication']} - ${p['dosage']}'),
                    subtitle: Text('Schedule: ${p['schedule']}'),
                    leading: const Icon(Icons.medical_services),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
