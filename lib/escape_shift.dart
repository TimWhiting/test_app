import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'intents.dart';

class EscapeShiftPage extends StatefulWidget {
  EscapeShiftPage({Key key, @required this.title}) : super(key: key);
  final String title;
  @override
  _EscapeShiftPageState createState() => _EscapeShiftPageState();
}

class _EscapeShiftPageState extends State<EscapeShiftPage> {
  TextEditingController textController;
  FocusNode textFieldFocus;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocus = FocusNode();
    textFieldFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Button1'),
              onPressed: () {},
            ),
            GestureDetector(
              onTap: () => textFieldFocus.requestFocus(),
              child: Actions(
                actions: {
                  IndentIntent: IndentationAction(),
                  DedentIntent: DedentationAction(),
                  EscapeTabFocusIntent: EscapeTabFocusAction(),
                },
                child: Shortcuts(
                  shortcuts: textFieldFocus.hasFocus
                      ? {
                          LogicalKeySet(LogicalKeyboardKey.tab):
                              IndentIntent(textController),
                          LogicalKeySet(LogicalKeyboardKey.shift,
                                  LogicalKeyboardKey.tab):
                              DedentIntent(textController),
                          LogicalKeySet(LogicalKeyboardKey.shift,
                                  LogicalKeyboardKey.escape):
                              EscapeTabFocusIntent(textFieldFocus, next: false),
                          LogicalKeySet(LogicalKeyboardKey.escape):
                              EscapeTabFocusIntent(textFieldFocus, next: true)
                        }
                      : {},
                  child: TextField(
                    focusNode: textFieldFocus,
                    controller: textController,
                    textInputAction: TextInputAction.newline,
                    maxLines: 30,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Button2'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Button3'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Button4'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
