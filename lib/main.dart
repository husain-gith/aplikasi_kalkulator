import 'package:flutter/material.dart';

void main() => runApp(KalkulatorApp());

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Flutter',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: KalkulatorHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KalkulatorHome extends StatefulWidget {
  const KalkulatorHome({super.key});

  @override
  _KalkulatorHomeState createState() => _KalkulatorHomeState();
}

class _KalkulatorHomeState extends State<KalkulatorHome> {
  String _layar = '';
  String _angkaPertama = '';
  String _angkaKedua = '';
  String _operator = '';

  void _tekanTombol(String nilai) {
    setState(() {
      if (nilai == 'C') {
        _layar = '';
        _angkaPertama = '';
        _angkaKedua = '';
        _operator = '';
      } else if (nilai == '+' || nilai == '-' || nilai == '×' || nilai == '÷') {
        if (_angkaPertama.isEmpty) return;
        _operator = nilai;
        _layar += ' $nilai ';
      } else if (nilai == '=') {
        if (_angkaPertama.isEmpty || _operator.isEmpty || _angkaKedua.isEmpty) return;
        double hasil = 0;
        double a = double.parse(_angkaPertama);
        double b = double.parse(_angkaKedua);
        switch (_operator) {
          case '+':
            hasil = a + b;
            break;
          case '-':
            hasil = a - b;
            break;
          case '×':
            hasil = a * b;
            break;
          case '÷':
            hasil = b != 0 ? a / b : 0;
            break;
        }
        _layar = hasil.toString();
        _angkaPertama = _layar;
        _angkaKedua = '';
        _operator = '';
      } else {
        _layar += nilai;
        if (_operator.isEmpty) {
          _angkaPertama += nilai;
        } else {
          _angkaKedua += nilai;
        }
      }
    });
  }

  Widget _buatTombol(String nilai, {Color warna = const Color.fromARGB(255, 19, 18, 18)}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _tekanTombol(nilai),
          style: ElevatedButton.styleFrom(
            backgroundColor: warna,
            padding: EdgeInsets.all(22),
          ),
          child: Text(
            nilai,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator Sederhana Delisha')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _layar,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [_buatTombol('7'), _buatTombol('8'), _buatTombol('9'), _buatTombol('÷', warna: Colors.orange)]),
              Row(children: [_buatTombol('4'), _buatTombol('5'), _buatTombol('6'), _buatTombol('×', warna: Colors.orange)]),
              Row(children: [_buatTombol('1'), _buatTombol('2'), _buatTombol('3'), _buatTombol('-', warna: Colors.orange)]),
              Row(children: [_buatTombol('0'), _buatTombol('C', warna: Colors.red), _buatTombol('=', warna: Colors.green), _buatTombol('+', warna: Colors.orange)]),
            ],
          ),
        ],
      ),
    );
  }
}
