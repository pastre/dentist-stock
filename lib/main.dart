import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: StockListWidget(),
    );
  }
}

class StockListWidget extends StatelessWidget {
  const StockListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Entrar em um estoque',
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Digite o nome do estoque'),
                    content: TextField(),
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: Text("salve"),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
