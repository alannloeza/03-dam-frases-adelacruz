import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frases_app/data/frases_db.dart';
import 'package:frases_app/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Valida, crea, edita, cancela y elimina usando SQLite en Android',
    (tester) async {
      final db = FrasesDb.instancia;
      final iniciales = await db.obtenerTodas();
      final cantidad = iniciales.length;

      await tester.pumpWidget(const FrasesApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Guardar frase'));
      await tester.pumpAndSettle();
      expect(find.text('Escribe al menos 5 caracteres'), findsOneWidget);
      expect(find.text('Escribe el autor'), findsOneWidget);

      const original = '  Frase temporal para probar el CRUD.  ';
      const editada = 'Frase temporal editada correctamente.';
      await tester.enterText(find.byType(TextFormField).at(0), original);
      await tester.enterText(find.byType(TextFormField).at(1), '  Prueba  ');
      await tester.tap(find.text('Guardar frase'));
      await tester.pumpAndSettle();
      expect(find.text('Mis frases (${cantidad + 1})'), findsOneWidget);
      expect(find.text('“${original.trim()}”'), findsOneWidget);
      final creada = (await db.obtenerTodas()).first;
      expect(creada.frase, original.trim());
      expect(creada.autor, 'Prueba');

      await tester.tap(find.text('“${original.trim()}”'));
      await tester.pumpAndSettle();
      expect(find.text('Editar frase'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField).at(0), editada);
      await tester.tap(find.text('Guardar cambios'));
      await tester.pumpAndSettle();
      expect(find.text('“$editada”'), findsOneWidget);
      expect((await db.obtenerTodas()).first.id, creada.id);

      final tarjeta = find.ancestor(
        of: find.text('“$editada”'),
        matching: find.byType(Card),
      );
      final eliminar = find.descendant(
        of: tarjeta,
        matching: find.byTooltip('Eliminar'),
      );
      await tester.tap(eliminar);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(find.text('“$editada”'), findsOneWidget);

      await tester.tap(eliminar);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
      await tester.pumpAndSettle();
      expect(find.text('“$editada”'), findsNothing);
      expect(find.text('Mis frases ($cantidad)'), findsOneWidget);
      expect((await db.obtenerTodas()).length, cantidad);
      expect(find.text('Frase eliminada'), findsOneWidget);
    },
  );
}
