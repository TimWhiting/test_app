import 'dart:async';

import 'package:flutter/material.dart';

class IndentIntent extends Intent {
  const IndentIntent(this.textController, {this.inline = true});
  final TextEditingController textController;
  final bool inline;
}

class DedentIntent extends Intent {
  const DedentIntent(this.textController);
  final TextEditingController textController;
}

class IndentationAction extends Action<IndentIntent> {
  @override
  Object invoke(covariant IndentIntent intent) {
    if (intent.inline) {
      final oldValue = intent.textController.value;
      final newComposing = TextRange.collapsed(oldValue.composing.start);
      final newSelection =
          TextSelection.collapsed(offset: oldValue.selection.start + 1);

      final newText = StringBuffer(oldValue.selection.isValid
          ? oldValue.selection.textBefore(oldValue.text)
          : oldValue.text);
      newText.write('\t');
      newText.write(oldValue.selection.isValid
          ? oldValue.selection.textAfter(oldValue.text)
          : '');
      intent.textController.value = intent.textController.value.copyWith(
        composing: newComposing,
        text: newText.toString(),
        selection: newSelection,
      );
    } else {
      // TODO: Indent at beginning of line of each line that is part of selection
    }

    return '';
  }
}

class DedentationAction extends Action<DedentIntent> {
  @override
  Object invoke(covariant DedentIntent intent) {
    // TODO: Dedent at beginning of line of each line that is part of selection

    return '';
  }
}

class EscapeTabFocusIntent extends Intent {
  const EscapeTabFocusIntent(this.textFieldFocus, {this.next});
  final FocusNode textFieldFocus;
  final bool next;
}

class EscapeTabFocusAction extends Action<EscapeTabFocusIntent> {
  @override
  Object invoke(covariant EscapeTabFocusIntent intent) {
    if (intent.next) {
      intent.textFieldFocus.nextFocus();
    } else {
      intent.textFieldFocus.previousFocus();
    }
    return '';
  }
}

class ExitTabFocusIntent extends Intent {
  const ExitTabFocusIntent(this.textFieldFocus, this.textTabFocus);
  final FocusNode textFieldFocus;
  final ValueNotifier<bool> textTabFocus;
}

class EnterTabFocusAction extends Action<EnterTabFocusIntent> {
  @override
  Object invoke(covariant EnterTabFocusIntent intent) {
    intent.textFieldFocusEnabled.value = true;
    return '';
  }
}

class EnterTabFocusIntent extends Intent {
  const EnterTabFocusIntent(this.textFieldFocus, this.textFieldFocusEnabled);
  final FocusNode textFieldFocus;
  final ValueNotifier<bool> textFieldFocusEnabled;
}

class ExitTabFocusAction extends Action<ExitTabFocusIntent> {
  @override
  Object invoke(covariant ExitTabFocusIntent intent) {
    intent.textFieldFocus.unfocus();
    intent.textTabFocus.value = false;
    return '';
  }
}
