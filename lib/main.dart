import 'package:flutter/material.dart';
import 'package:test_app/escape_enter.dart' as ent;
import 'package:test_app/escape_shift.dart' as esc;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => HomePage(title: 'Flutter Tab TextField Demo'),
        '/esc': (context) => esc.EscapeShiftPage(
            title: 'Escape and Shift Escape to exit Tab Focus'),
        '/enter': (context) => ent.EscapeEnterPage(
            title: 'Escape to exit TabScope, Enter to enter TabScope'),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/esc'),
              child: Text('Tab, Esc and Shift Esc'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/enter'),
              child: Text('Tab, Esc and Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
