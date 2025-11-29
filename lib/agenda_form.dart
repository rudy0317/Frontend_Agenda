import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda_service.dart';

class AgendaFormPage extends StatefulWidget {
  final Agenda? agenda;

  const AgendaFormPage({super.key, this.agenda});

  @override
  State<AgendaFormPage> createState() => _AgendaFormPageState();
}

class _AgendaFormPageState extends State<AgendaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _ketController = TextEditingController();
  final _service = AgendaService();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.agenda != null) {
      _judulController.text = widget.agenda!.judul;
      _ketController.text = widget.agenda!.keterangan;
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _ketController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final agenda = Agenda(
      id: widget.agenda?.id,
      judul: _judulController.text.trim(),
      keterangan: _ketController.text.trim(),
    );

    try {
      if (agenda.id == null) {
        await _service.create(agenda);
      } else {
        await _service.update(agenda.id!, agenda);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              agenda.id == null
                  ? 'Agenda berhasil ditambahkan'
                  : 'Agenda berhasil diperbarui',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.agenda != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Agenda' : 'Agenda Baru'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit ? 'Ubah detail agenda kamu' : 'Isi detail agenda kamu',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul agenda',
                  hintText: 'Misal: Belajar Flutter CRUD',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ketController,
                decoration: const InputDecoration(
                  labelText: 'Keterangan',
                  hintText: 'Tambahkan catatan tambahan kalau perlu',
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Agenda'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
