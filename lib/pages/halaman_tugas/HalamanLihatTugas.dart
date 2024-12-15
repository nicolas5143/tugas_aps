import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_aps/pages/halaman_tugas/HalamanTambahTugas.dart';
import 'package:tugas_aps/util.dart';
import 'package:tugas_aps/db_helper.dart';

class HalamanLihatTugas extends StatefulWidget {
  const HalamanLihatTugas({super.key});

  @override
  State<HalamanLihatTugas> createState() => _HalamanLihatTugasState();
}

class _HalamanLihatTugasState extends State<HalamanLihatTugas> {
  final dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> dapatkanSemuaTugas() async {
    final db = await dbHelper.database;
    print("Fetching tasks from the database...");
    return await db.query('tugas');
  }

  Future<void> hapusTugas(String judul) async {
    final db = await DatabaseHelper().database; // Get the database instance
    await db.delete(
      'tugas', // Table name
      where: 'judul = ?', // Condition for deletion
      whereArgs: [judul], // Arguments for the condition
    );
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanLihatTugas()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                'Tugas kamu',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1), // Background color of the search box
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari tugas", // Placeholder text
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xBA49454F)), // Placeholder style
                  border: InputBorder.none, // Remove border
                  suffixIcon: Icon(Icons.search, color: Color(0xBA49454F), size: 24,), // Search icon
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Padding inside the TextField
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanTambahTugas()));
              setState(() {});
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent)
            ),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xFF5DB075),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: const Text(
                  '+ tambahkan tugas',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                )),
          ),
          const SizedBox(height: 21,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child:
              FutureBuilder<List<Map<String, dynamic>>>(
                future: dapatkanSemuaTugas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Column(
                      children: [
                        const SizedBox(height: 160,),
                        Image.asset('images/sleep_icon.png', width: 148, height: 148,),
                        const SizedBox(height: 20,),
                        const Text('Belum ada tugas yang terdaftar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
                      ],
                    ));
                  } else {
                    // Build the ListView with the fetched data
                    final tasks = snapshot.data!;
                    return ListView.builder(
                      itemCount: tasks.length, // Number of items in the list
                      itemBuilder: (context, index) {
                        final task = tasks[index]; // Access the current task
                        return ContainerTugasDelEdit(judul: task['judul'], matkul: task['matkul'], tanggal: task['tanggal'], waktu: task['waktu'],);
                      },
                    );
                  }
                },
              ),
              ),
            ),
        ],
      ),
    ));
  }
}
