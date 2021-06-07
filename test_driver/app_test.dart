// Imports the Flutter Driver API.
// import 'dart:convert';
// import 'dart:io';

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';




void main(List<String> args) {

  group('QR Generator App', () {

    final textFieldFinder = find.byType('TextField');
    final btnFinder = find.byType('FloatingActionButton');
    final qrCodeFinder = find.byValueKey('qr_code');


    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect(dartVmServiceUrl:args.length>=1?args[args.length-2]:null);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });


    test('generate qr', () async {

      final text = args.length>=2?args[args.length-1]:'Success';
      await driver.tap(textFieldFinder);
      await driver.enterText(text);
      sleep(Duration(seconds: 1));
      await driver.tap(btnFinder);
      // Take screenshot
      final List<int> pixels = await driver.screenshot();
      final File file = File('./../test.png');
      await file.writeAsBytes(pixels);

      expect(await isPresent(qrCodeFinder, driver), true);
    });
  });
}


Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver, {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(finder, timeout: timeout);
    return true;
  } catch (e) {
    return false;
  }
}