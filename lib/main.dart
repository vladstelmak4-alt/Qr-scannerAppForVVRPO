import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context){
      return const MaterialApp(home: HomeScreen()); //старт с главного огна типо
  }
}

//Главный экран
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF000000),
      appBar: AppBar(title: const Text("Терминал лаборанта", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.black),),
        backgroundColor: Color(0xFFE60026), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //первая кнопка, она будет вести на сканер
            ElevatedButton(
              onPressed: () async{
                final scannedCode = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(builder: (context) => const QrScannerScreen(),),
                );

                // Если со сканера вернулся результат, обрабатываем его
                if (scannedCode != null) {
                  debugPrint('Получен код на главном экране: $scannedCode');
                  // Здесь можно, например, отправить scannedCode на бэкенд через Dio
                  // или показать его пользователю.
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE60026),
                minimumSize: const Size(200, 200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Чем меньше цифра, тем острее углы (8-12 — оптимально)
                ),
              ),
              child: Text("Открыть сканнер", style: TextStyle(color: Colors.black,fontSize: 60 ,fontStyle: FontStyle.normal), ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: (){
                  //по идее должен будет вызываться метод выбора фотки из галереи но тут он не написан(
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE60026),
                  minimumSize: const Size(200, 200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Чем меньше цифра, тем острее углы (8-12 — оптимально)
                  ),
                ),

                child: Text("Выбрать фото из галереи", style: TextStyle(fontSize: 60, color: Colors.black)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                //тута будет переход на экран истории сканирований
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE60026),
                minimumSize: const Size(200, 200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Чем меньше цифра, тем острее углы (8-12 — оптимально)
                ),
              ),
              child: Text("Открыть Историю сканирований", style: TextStyle(color: Colors.black,fontSize: 45 ,fontStyle: FontStyle.italic), ),
            ),
          ],
        ),
      ),
    );
  }
}

//Сканер
class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  //контроллер управления камерой и сканированием
  final MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  bool isScanning = true;

  @override
  void dispose() {
    // освобождаем ресурсы камеры при закрытии экрана
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    //проверка что мы все еще сканируем
    if (!isScanning || capture.barcodes.isEmpty) return;

    final Barcode barcode = capture.barcodes.first;
    final String? rawValue = barcode.rawValue;

    if (rawValue != null) {
      //флаг,чтобы избежать повторную обработку
      setState(() {
        isScanning = false;
      });

      debugPrint('Распознан QR-код: $rawValue');

      Navigator.of(context).pop(rawValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GSTU Сканер")),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),
          // Текст подсказки поверх камеры
          const Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Наведите камеру на QR-код',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}