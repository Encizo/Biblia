import 'package:flutter/material.dart';
import '../services/bible_api_service.dart';
import 'study_page.dart';

class ChapterPage extends StatefulWidget {
  final String bookSlug;
  final String bookName;

  const ChapterPage({super.key, required this.bookSlug, required this.bookName});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  int selectedChapter = 1;
  int maxChapters = 0;
  List<String> verses = [];
  bool isLoading = false;
  String error = '';
  final BibleApiService apiService = BibleApiService();

  @override
  void initState() {
    super.initState();
    _loadBookInfoAndVerses();
  }

  Future<void> _loadBookInfoAndVerses() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      maxChapters = await apiService.getTotalChapters(widget.bookSlug);

      final fetchedVerses = await apiService.getChapterVerses(widget.bookSlug, selectedChapter);

      setState(() {
        verses = fetchedVerses;
      });
    } catch (e) {
      setState(() {
        error = 'Erro ao carregar capítulo: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchVerses() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final fetchedVerses = await apiService.getChapterVerses(widget.bookSlug, selectedChapter);
      setState(() {
        verses = fetchedVerses;
      });
    } catch (e) {
      setState(() {
        error = 'Erro ao carregar capítulo: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${widget.bookName} $selectedChapter',
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: selectedChapter > 1
                      ? () {
                          setState(() {
                            selectedChapter--;
                          });
                          _fetchVerses();
                        }
                      : null,
                ),
                Text(
                  'Capítulo $selectedChapter',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: selectedChapter < maxChapters
                      ? () {
                          setState(() {
                            selectedChapter++;
                          });
                          _fetchVerses();
                        }
                      : null,
                ),
              ],
            ),
          ),
          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white)))
          else if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: verses.length,
                itemBuilder: (context, index) {
                  final verseText = verses[index];
                  return ListTile(
                    title: Text(
                      verseText,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(Icons.edit_note, color: Colors.white54),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudyPage(verseText: verseText),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
