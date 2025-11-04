// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util' as js_util;

//=========================== Disable Spellcheck ===========================

const _jsSetDisableSpellCheckTimer = '''
var disableSpellCheck = setInterval(function () {
      var elements = document.getElementsByTagName('flt-glass-pane');
      for (let child of elements[0].shadowRoot.children) {
        if (child.tagName.toLowerCase() == 'form') {
          let textFields = child.getElementsByTagName('textarea');
          for (let textField of textFields) {
            textField.setAttribute('spellcheck', 'false');
          }
        }
      }
    }, 1000);
''';

bool _isTimerSet = false;

void disableSpellCheck() {
  if (!_isTimerSet) {
    js_util.callMethod(
      js_util.globalThis,
      'eval',
      [_jsSetDisableSpellCheckTimer],
    );
    _isTimerSet = true;
  }
}

//=========================== Disable Builtin Search ===========================

// 114 -> F3
// 70  -> F
const _jsDisableBuiltinSearch = '''
  window.addEventListener("keydown",function (e) {
    if (e.keyCode === 114 || ((e.ctrlKey || e.metaKey) && e.keyCode === 70)) {
      e.preventDefault();
    }
  })
''';

void disableBuiltInSearch() {
  js_util.callMethod(js_util.globalThis, 'eval', [_jsDisableBuiltinSearch]);
}
