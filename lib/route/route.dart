import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ocr_text/feature/ocr/screen/closing_reading.dart';
import 'package:ocr_text/feature/ocr/screen/opening_reading.dart';
import 'package:ocr_text/feature/ocr/screen/payment_successful.dart';
import 'package:ocr_text/feature/ocr/screen/scanner_screen.dart';
import 'package:ocr_text/feature/ocr/screen/tank_reading.dart';

class AppRoute {
  static String scannerScreen = "/scannerScreen";
  static String paymentSuccessful = "/paymentSuccessful";
  static String tankReading = "/tankReading";
  static String openingReading = "/openingReading";
  static String closingReading = "/closingReading";

  static String getSignupScreen() => scannerScreen;
  static String getPaymentSuccessful() => paymentSuccessful;
  static String getTankReading() => tankReading;
  static String getOpeningReading() => openingReading;
  static String getClosingReading() => closingReading;

  static List<GetPage> routes = [
    GetPage(name: scannerScreen, page: () => ScannerScreen()),
    GetPage(
      name: paymentSuccessful,
      page: () => PaymentSuccessful(extractedText: 'text'),
    ),
    GetPage(name: tankReading, page: () => TankReading()),
    GetPage(name: openingReading, page: () => OpeningReading()),
    GetPage(name: closingReading, page: () => ClosingReading()),
  ];
}
