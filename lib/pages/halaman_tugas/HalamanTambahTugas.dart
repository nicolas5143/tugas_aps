import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas_aps/pages/halaman_tugas/HalamanBuatCatatanTugas.dart';
import '../../db_helper.dart';

class HalamanTambahTugas extends StatefulWidget {
  const HalamanTambahTugas({super.key});

  @override
  State<HalamanTambahTugas> createState() => _HalamanTambahTugasState();
}

class _HalamanTambahTugasState extends State<HalamanTambahTugas> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _matkulController = TextEditingController();
  final _frekController = TextEditingController();
  final _waktuController = TextEditingController();

  String errorMessage = '';

  DateTime? selectedDate;
  Color warnaBorderTanggal = Colors.black;
  bool validasiTanggal = true;

  final dbHelper = DatabaseHelper();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Earliest date the user can pick
      lastDate: DateTime(2100), // Latest date the user can pick
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        validasiTanggal = true;
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> masukkanTugas(Map<String, dynamic> atributTugas) async {
    try {
      final db =
          await dbHelper.database; // Ensure the database is open and ready
      await db.insert(
        'tugas', // Table name
        atributTugas, // Data to insert
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting data: $e");
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final cekWaktu = num.tryParse(_waktuController.text);
      final cekFrek = num.tryParse(_frekController.text);

      if (cekFrek == null || cekWaktu == null) {
        setState(() {
          errorMessage = "Mohon isi sesuai format yang diberikan";
        });
        return;
      }

      String tanggal = selectedDate.toString().split(' ')[0];
      Map<String, String> atribut_tugas = {
        'judul': _judulController.text,
        'matkul': _matkulController.text,
        'tanggal': tanggal,
        'waktu': _waktuController.text,
        'frek': _frekController.text,
      };
      await masukkanTugas(atribut_tugas);

      // Show the popup and automatically navigate after a few seconds
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissal by tapping outside
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color(0xFFD7FFE2),
            title: Icon(
              Icons.check_circle_outline_rounded,
              size: 75,
            ),
            content: Text(
              'Tugas telah berhasil ditambahkan!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          );
        },
      );

      // Close the dialog and navigate after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.pop(context);
      });

      // Clear the form after submission
      _judulController.clear();
      _matkulController.clear();
      _frekController.clear();
      _waktuController.clear();
      setState(() {
        selectedDate = null;
      });
    } else {
      if (selectedDate == null) {
        setState(() {
          validasiTanggal = false;
        });
      }

      setState(() {
        errorMessage = 'Mohon lengkapi semua data yang diperlukan sebelum melanjtukan!';
      });
    }
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    // Show dialog and wait for user response
    return await showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD7FFE2),
          actionsAlignment: MainAxisAlignment.center,
          content: const Text('Apakah Anda yakin ingin kembali ke halaman sebelumnya?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
          actions: [
            TextButton(
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(const Size(103, 47)),
                backgroundColor: WidgetStateProperty.all(const Color(0x8C5DB075)),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Tidak', style: TextStyle(fontSize: 14, color: Color(0xFF121212))),
            ),
            TextButton(
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(const Size(103, 47)),
                backgroundColor: WidgetStateProperty.all(const Color(0x69FF4D4D)),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.pop(context);
              },
              child: const Text('Ya', style: TextStyle(fontSize: 14, color: Color(0xFF121212))),
            ),
          ],
        );
      },
    ) ??
        false; // Return false if dialog is dismissed without a choice
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      _showExitDialog(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Tambahkan Tugas',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'oaisdj'),
                  )
                ],
              ),
              const Divider(
                indent: 37,
                endIndent: 37,
                color: Color(0xFFD9D9D9),
                thickness: 1,
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // untuk memasukkan judul tugas
                                  const Text(
                                    'Judul',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextFormField(
                                    controller: _judulController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan judul tugas',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0x61121212),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(0x15121212),
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(
                                              0xFF212121), // Change to your desired focus color
                                          width: 1.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border for the error
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border when focused during error
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // untuk memasukkan kategori mata kuliah
                                  const Text(
                                    'Kategori Mata Kuliah',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextFormField(
                                    controller: _matkulController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan kategori mata kuliah',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0x61121212),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(0x15121212),
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(
                                              0xFF212121), // Change to your desired focus color
                                          width: 1.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border for the error
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border when focused during error
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // untuk memasukkan tenggat tugas
                                  const Text(
                                    'Tenggat',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: validasiTanggal ? const Color(0x15121212) : Colors.red),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDate != null
                                                ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                                                : 'Pilih tanggal',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: selectedDate != null ? Colors.black : Color(0x61121212),
                                            ),
                                          ),
                                          const Icon(Icons.calendar_today,
                                              color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // untuk memasukkan frekuensi pengingat
                                  const Text(
                                    'Frekuensi Pengingat',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextFormField(
                                    controller: _frekController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          'Masukkan frekuensi pengingat',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0x61121212),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(0x15121212),
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(
                                              0xFF212121), // Change to your desired focus color
                                          width: 1.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border for the error
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border when focused during error
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // untuk memasukkan waktu notifikasi
                                  const Text(
                                    'Waktu Notifikasi',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextFormField(
                                    controller: _waktuController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          'Masukkan waktu notifikasi',
                                      hintStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0x61121212),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(0x15121212),
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Color(
                                              0xFF212121), // Change to your desired focus color
                                          width: 1.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border for the error
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors
                                              .red, // Red border when focused during error
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),

                                  // tombol untuk buat catatan
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.zero),
                                        backgroundColor: WidgetStateProperty.all(
                                            const Color(0xFF5DB075))),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HalamanBuatCatatanTugas()));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'Buat Catatan Tugas',
                                        style: TextStyle(color: Color(0xDD121212)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                                const SizedBox(height: 5,),

                                Text(errorMessage,
                                  style: const TextStyle(color: Color(0xFFFF0000), fontSize: 14),
                                ),

                                const SizedBox(height: 15,),


                          ],
                        ),

                        // tombol untuk submit
                        ElevatedButton(
                            style: ButtonStyle(
                                padding:
                                WidgetStateProperty.all(EdgeInsets.zero),
                                backgroundColor: WidgetStateProperty.all(
                                    const Color(0xFF5DB075))),
                            onPressed: _submitForm,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Color(0xDD121212), fontSize: 18),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
