import 'package:flutter/material.dart';
import 'package:tugas_aps/util.dart';
import '../db_helper.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> dapatkanSemuaTugas() async {
    final db = await dbHelper.database;
    print("Fetching tasks from the database...");
    return await db.query('tugas');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'images/profile_pict.jpg',
                      height: 48,
                      width: 48,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Halo, nama_user',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, '/halaman_login')},
                style: ButtonStyle(
                    shadowColor: WidgetStateProperty.all(Colors.transparent)),
                child: const Icon(
                  Icons.door_front_door_outlined,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 26,
          ),

          // untuk tugas
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0x17000000)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tugas',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    color: Color(0xFFD9D9D9),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    height: 150,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: dapatkanSemuaTugas(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Belum ada tugas yang terdaftar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),));
                        } else {
                          // Build the ListView with the fetched data
                          final tasks = snapshot.data!;
                          return ListView.builder(
                            itemCount: tasks.length, // Number of items in the list
                            itemBuilder: (context, index) {
                              final task = tasks[index]; // Access the current task
                              return ContainerTugas(judul: task['judul'], matkul: task['matkul'], tanggal: task['tanggal'], waktu: task['waktu'],);
                            },
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(
                      height: 48,
                      child: Icon(
                        Icons.more_horiz,
                        size: 48,
                      )),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // untuk jadwal
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0x17000000)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                  )
                ]),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jadwal',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(
                    color: Color(0xFFD9D9D9),
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    height: 150,
                    child: ContainerJadwal(
                      judul: 'Interaksi Manusia dan Komputer',
                      hari: 'Selasa',
                      jam: '16:20',
                      durasi_jam: '1',
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                      height: 48,
                      child: Icon(
                        Icons.more_horiz,
                        size: 48,
                      )),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
