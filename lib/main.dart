import 'package:flutter/material.dart';

void main() {
  runApp(const DentistInventoryApp());
}

class DentistInventoryApp extends StatelessWidget {
  const DentistInventoryApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: JoinedInventoryListWidget(),
    );
  }
}

class JoinedInventoryListWidget extends StatelessWidget {
  const JoinedInventoryListWidget({
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
                        onPressed: null,
                        child: Text('Entrar'),
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
