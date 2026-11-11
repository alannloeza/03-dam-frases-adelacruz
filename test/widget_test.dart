import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frases_app/models/frase.dart';
import 'package:frases_app/screens/formulario_screen.dart';

void main() {
  testWidgets('Rechaza espacios, frases cortas y autor vacío', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FormularioScreen()));
    await tester.enterText(find.byType(TextFormField).at(0), '    ');
    await tester.enterText(find.byType(TextFormField).at(1), '    ');
    await tester.tap(find.text('Guardar frase'));
    await tester.pumpAndSettle();
    expect(find.text('Escribe al menos 5 caracteres'), findsOneWidget);
    expect(find.text('Escribe el autor'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'abcd');
    await tester.tap(find.text('Guardar frase'));
    await tester.pumpAndSettle();
    expect(find.text('Escribe al menos 5 caracteres'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'abcde');
    await tester.tap(find.text('Guardar frase'));
    await tester.pumpAndSettle();
    expect(find.text('Escribe al menos 5 caracteres'), findsNothing);
    expect(find.text('Escribe el autor'), findsOneWidget);
  });

  testWidgets('El formulario de edición conserva frase y autor', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FormularioScreen(
          frase: Frase(
            id: 7,
            frase: 'Eres el mejor, eres único',
            autor: 'Rafael Villegas',
          ),
        ),
      ),
    );
    expect(find.text('Editar frase'), findsOneWidget);
    expect(find.text('Guardar cambios'), findsOneWidget);
    expect(find.text('Eres el mejor, eres único'), findsOneWidget);
    expect(find.text('Rafael Villegas'), findsOneWidget);
  });
}
