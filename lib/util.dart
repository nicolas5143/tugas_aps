import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            fillColor: const Color(0xFFF6F6F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFE8E8E8), width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFE8E8E8), width: 0.5),
            ),
            hintText: text,
            hintStyle: const TextStyle(
              color: Color(0xFFBDBDBD),
              fontSize: 16,
            )),
      ),
    );
  }
}

class ContainerTugas extends StatelessWidget {
  const ContainerTugas(
      {super.key,
      required this.judul,
      required this.matkul,
      required this.tanggal,
      required this.waktu,
      this.catatan});

  final String judul, matkul, tanggal, waktu;
  final String? catatan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(judul,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        Text(
          matkul,
          style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        Text('$tanggal; $waktu',
            style: const TextStyle(fontSize: 14, color: Color(0xFF757575))),
        const Text('Lihat catatan',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)))
      ],
    );
  }
}

class ContainerJadwal extends StatelessWidget {
  const ContainerJadwal(
      {super.key,
      required this.judul,
      required this.hari,
      required this.jam,
      required this.durasi_jam,
      this.catatan});

  final String judul, hari, jam, durasi_jam;
  final String? catatan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(judul,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        Text(
          '$hari, $jam',
          style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        Text('$durasi_jam jam',
            style: const TextStyle(fontSize: 14, color: Color(0xFF757575))),
        const Text('Lihat catatan',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)))
      ],
    );
  }
}

class ContainerTugasDelEdit extends StatefulWidget {
  const ContainerTugasDelEdit(
      {super.key,
      required this.judul,
      required this.matkul,
      required this.tanggal,
      required this.waktu,
      this.catatan});

  final String judul, matkul, tanggal, waktu;
  final String? catatan;

  @override
  State<ContainerTugasDelEdit> createState() => _ContainerTugasDelEditState();
}

class _ContainerTugasDelEditState extends State<ContainerTugasDelEdit> {

  Future<void> deleteTugas(String judul) async {
    final db = await DatabaseHelper().database; // Get the database instance
    await db.delete(
      'tugas', // Table name
      where: 'judul = ?', // Condition for deletion
      whereArgs: [judul], // Arguments for the condition
    );
    print('Data deleted successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContainerTugas(
              judul: widget.judul,
              matkul: widget.matkul,
              tanggal: widget.tanggal,
              waktu: widget.waktu),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await deleteTugas(widget.judul);
                    print('tugas ${widget.judul} berhasil dihapus');
                    setState(() {});
                  },
                  style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      foregroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent)),
                  child: const Icon(
                    Icons.restore_from_trash_outlined,
                    size: 30,
                    color: Colors.black,
                  )),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      foregroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent)),
                  child: const Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.black,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
