import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/openai_service.dart';

class StudyPage extends StatefulWidget {
  final String verseText;

  const StudyPage({super.key, required this.verseText});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  final OpenAIService _openAI = OpenAIService();
  String? studyText;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    generateStudy();
  }

  Future<void> generateStudy() async {
    try {
      final result = await _openAI.generateStudy(widget.verseText);
      setState(() {
        studyText = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<void> saveStudy() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('studies')
        .add({
      'verse': widget.verseText,
      'studyText': studyText,
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Estudo salvo com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Estudo Avançado', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : error != null
              ? Center(
                  child: Text('Erro: $error', style: const TextStyle(color: Colors.redAccent)),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Card(
                            color: const Color(0xFF1E1E1E),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                studyText ?? '',
                                style: const TextStyle(fontSize: 16, color: Colors.white70),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: saveStudy,
                        icon: const Icon(Icons.save),
                        label: const Text("Salvar Estudo"),
                      ),
                    ],
                  ),
                ),
    );
  }
}