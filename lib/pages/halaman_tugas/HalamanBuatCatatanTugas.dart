import 'package:flutter/material.dart';

class HalamanBuatCatatanTugas extends StatefulWidget {
  const HalamanBuatCatatanTugas({super.key});

  @override
  State<HalamanBuatCatatanTugas> createState() => _HalamanBuatCatatanTugasState();
}

class _HalamanBuatCatatanTugasState extends State<HalamanBuatCatatanTugas> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // header
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
                        Navigator.pop(context);
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
                      'Buat Catatan Tugas',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, decoration: TextDecoration.none, color: Colors.black, fontFamily: 'San Fransisco  '),
                    )
                  ],
                ),
                const SizedBox(height: 50),

                // receiving input from user
                // Text('Catatan tugas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, decoration: TextDecoration.none, color: Colors.black, fontFamily: 'Roboto')),
                Text('Catatan tugas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text('Catatan tugas', style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
          ),
        )
    );
  }
}
