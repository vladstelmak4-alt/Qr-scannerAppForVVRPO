import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

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
        backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(title: const Text("Терминал лаборанта", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.white),),
        backgroundColor: Colors.grey[900], centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //первая кнопка, она будет вести на сканер
            ElevatedButton(
              onPressed: (){
                //тута будет переход на экран сканера типо Navigator.push()..
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                minimumSize: const Size(200, 200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Чем меньше цифра, тем острее углы (8-12 — оптимально)
                ),
              ),
              child: Text("Открыть сканнер", style: TextStyle(color: Colors.white,fontSize: 60 ,fontStyle: FontStyle.italic), ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: (){
                  //по идее должен будет вызываться метод выбора фотки из галереи но тут он не написан(
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  minimumSize: const Size(200, 200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Чем меньше цифра, тем острее углы (8-12 — оптимально)
                  ),
                ),

                child: Text("Выбрать фото из галереи", style: TextStyle(fontSize: 60)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                //тута будет переход на экран истории сканирований
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                minimumSize: const Size(200, 200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Чем меньше цифра, тем острее углы (8-12 — оптимально)
                ),
              ),
              child: Text("Открыть Историю сканирований", style: TextStyle(color: Colors.white,fontSize: 45 ,fontStyle: FontStyle.italic), ),
            ),
          ],
        ),
      ),
    );
  }
}
