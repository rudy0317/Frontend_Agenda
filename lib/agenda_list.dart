import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda_form.dart';
import 'agenda_service.dart';

class AgendaListPage extends StatefulWidget {
  const AgendaListPage({super.key});

  @override
  State<AgendaListPage> createState() => _AgendaListPageState();
}

class _AgendaListPageState extends State<AgendaListPage> {
  final _service = AgendaService();
  late Future<List<Agenda>> _futureAgenda;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _futureAgenda = _service.getAll();
    });
  }

  Future<void> _openForm({Agenda? agenda}) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AgendaFormPage(agenda: agenda),
      ),
    );

    if (result == true) {
      _refresh();
    }
  }

  Future<void> _deleteAgenda(Agenda agenda) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0B0018),
        title: const Text(
          'Hapus agenda?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Yakin mau hapus "${agenda.judul}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (ok == true) {
      await _service.delete(agenda.id!);

      if (!mounted) return;

      _refresh();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agenda berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda // CYBERLOGDY'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF050010),
              Color(0xFF220055),
              Color(0xFF050010),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Manage agenda harian Rudy dalam vibes neon.\nTap card untuk edit, ikon trash untuk hapus.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB0A8FF),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<Agenda>>(
                future: _futureAgenda,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Gagal memuat data:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final data = snapshot.data ?? [];

                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada agenda.\nTap tombol + di pojok untuk menambah.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFFB0A8FF)),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) {
                      final item = data[i];
                      final initial = item.judul.isNotEmpty
                          ? item.judul[0].toUpperCase()
                          : '?';

                      return Card(
                        elevation: 12,
                        shadowColor:
                            const Color(0xFFFF00FF).withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFF00E5FF),
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => _openForm(agenda: item),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 46,
                                  width: 46,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFF00FF),
                                        Color(0xFF00E5FF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF00FF)
                                            .withValues(alpha: 0.6),
                                        blurRadius: 12,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    initial,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.judul,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.keterangan.isEmpty
                                            ? '-'
                                            : item.keterangan,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFB0A8FF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                  ),
                                  onPressed: () => _deleteAgenda(item),
                                  tooltip: 'Hapus',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New agenda'),
      ),
    );
  }
}
