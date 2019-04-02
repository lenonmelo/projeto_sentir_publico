# projeto_sentir

A new Flutter project.

## Getting Started

Perfil psicologa: psicologa2@teste.com.br

Senha:123456

Acessar o "Paciente 2"

Acessar os registros do diário do paciente e excluir.

Erro que ocorre

E/flutter (12863): [ERROR:flutter/lib/ui/ui_dart_state.cc(148)] Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe.
E/flutter (12863): At this point the state of the widget's element tree is no longer stable. To safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling inheritFromWidgetOfExactType() in the widget's didChangeDependencies() method.
E/flutter (12863): 
E/flutter (12863): #0      Element._debugCheckStateIsActiveForAncestorLookup.<anonymous closure> (package:flutter/src/widgets/framework.dart:3252:9)
E/flutter (12863): #1      Element._debugCheckStateIsActiveForAncestorLookup (package:flutter/src/widgets/framework.dart:3261:6)
E/flutter (12863): #2      Element.ancestorStateOfType (package:flutter/src/widgets/framework.dart:3309:12)
E/flutter (12863): #3      Navigator.of (package:flutter/src/widgets/navigator.dart:1376:19)
E/flutter (12863): #4      Navigator.pop (package:flutter/src/widgets/navigator.dart:1271:22)
E/flutter (12863): #5      pop (package:projeto_sentir/utils/nav.dart:18:13)
E/flutter (12863): #6      _VerdiarioPsicologaPageState.excluirdiario (package:projeto_sentir/pages/ver_diario_psicologa_page.dart:224:11)
E/flutter (12863): <asynchronous suspension>
E/flutter (12863): #7      _VerdiarioPsicologaPageState.confirmRemocao.<anonymous closure>.<anonymous closure> (package:projeto_sentir/pages/ver_diario_psicologa_page.dart:203:19)
E/flutter (12863): #8      _InkResponseState._handleTap (package:flutter/src/material/ink_well.dart:513:14)
E/flutter (12863): #9      _InkResponseState.build.<anonymous closure> (package:flutter/src/material/ink_well.dart:568:30)
E/flutter (12863): #10     GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:120:24)
E/flutter (12863): #11     TapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:242:9)
E/flutter (12863): #12     TapGestureRecognizer.handlePrimaryPointer (package:flutter/src/gestures/tap.dart:175:7)
E/flutter (12863): #13     PrimaryPointerGestureRecognizer.handleEvent (package:flutter/src/gestures/recognizer.dart:369:9)
E/flutter (12863): #14     PointerRouter._dispatch (package:flutter/src/gestures/pointer_router.dart:73:12)
E/flutter (12863): #15     PointerRouter.route (package:flutter/src/gestures/pointer_router.dart:101:11)
E/flutter (12863): #16     _WidgetsFlutterBinding&BindingBase&GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:214:19)
E/flutter (12863): #17     _WidgetsFlutterBinding&BindingBase&GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:192:22)
E/flutter (12863): #18     _WidgetsFlutterBinding&BindingBase&GestureBinding._handlePointerEvent (package:flutter/src/gestures/binding.dart:149:7)
E/flutter (12863): #19     _WidgetsFlutterBinding&BindingBase&GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:101:7)
E/flutter (12863): #20     _WidgetsFlutterBinding&BindingBase&GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:85:7)
E/flutter (12863): #21     _rootRunUnary (dart:async/zone.dart:1136:13)
E/flutter (12863): #22     _CustomZone.runUnary (dart:async/zone.dart:1029:19)
E/flutter (12863): #23     _CustomZone.runUnaryGuarded (dart:async/zone.dart:931:7)
E/flutter (12863): #24     _invoke1 (dart:ui/hooks.dart:223:10)
E/flutter (12863): #25     _dispatchPointerDataPacket (dart:ui/hooks.dart:144:5)
E/flutter (12863): 
