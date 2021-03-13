import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'intents.dart';

class EscapeEnterPage extends StatefulWidget {
  EscapeEnterPage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _EscapeEnterPageState createState() => _EscapeEnterPageState();
}

class _EscapeEnterPageState extends State<EscapeEnterPage>
    with WidgetsBindingObserver {
  TextEditingController textController;
  FocusNode textFieldFocus;
  ValueNotifier<bool> textFieldFocusEnabled;
  FocusNode outerFocus;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocusEnabled = ValueNotifier<bool>(false);
    textFieldFocus = FocusNode();
    outerFocus = FocusNode();

    textFieldFocusEnabled.addListener(() {
      setState(() {
        if (textFieldFocusEnabled.value) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            print('Text Node Focus');
            textFieldFocus.requestFocus();
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            print('Outer Node Focus');
            outerFocus.requestFocus();
          });
        }
      });
    });
    outerFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocus.dispose();
    textFieldFocusEnabled.dispose();
    outerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(textFieldFocusEnabled.value);
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
            Actions(
              actions: {
                IndentIntent: IndentationAction(),
                DedentIntent: DedentationAction(),
                ExitTabFocusIntent: ExitTabFocusAction(),
                EnterTabFocusIntent: EnterTabFocusAction(),
              },
              child: Shortcuts(
                shortcuts: {
                  if (!textFieldFocus.hasFocus)
                    LogicalKeySet(LogicalKeyboardKey.enter):
                        EnterTabFocusIntent(
                            textFieldFocus, textFieldFocusEnabled)
                },
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      return Actions.invoke(
                          context,
                          EnterTabFocusIntent(
                              textFieldFocus, textFieldFocusEnabled));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              outerFocus.hasFocus ? Colors.blue : Colors.black,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: textFieldFocusEnabled.value
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                        child: Focus(
                          focusNode: outerFocus,
                          descendantsAreFocusable: textFieldFocusEnabled.value,
                          child: Shortcuts(
                            shortcuts: textFieldFocus.hasFocus
                                ? {
                                    LogicalKeySet(LogicalKeyboardKey.tab):
                                        IndentIntent(textController),
                                    LogicalKeySet(LogicalKeyboardKey.shift,
                                            LogicalKeyboardKey.tab):
                                        DedentIntent(textController),
                                    LogicalKeySet(LogicalKeyboardKey.escape):
                                        ExitTabFocusIntent(textFieldFocus,
                                            textFieldFocusEnabled),
                                  }
                                : {},
                            child: TextField(
                              autofocus: true,
                              focusNode: textFieldFocus,
                              controller: textController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 30,
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
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
