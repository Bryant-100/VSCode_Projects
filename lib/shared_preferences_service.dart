import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
   static const String loanAmountKey = 'loanAmount';
  static const String interestRateKey = 'interestRate';
  static const String loanTermKey = 'loanTerm';
  static const String monthlyPaymentKey = 'monthlyPayment';
  static const String totalPaymentKey = 'totalPayment';

  // Save mortgage data
  Future<void> saveMortgageData({
    required double loanAmount,
    required double interestRate,
    required int loanTerm,
    required double monthlyPayment,
    required double totalPayment,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(loanAmountKey, loanAmount);
    await prefs.setDouble(interestRateKey, interestRate);
    await prefs.setInt(loanTermKey, loanTerm);
    await prefs.setDouble(monthlyPaymentKey, monthlyPayment);
    await prefs.setDouble(totalPaymentKey, totalPayment);
  }

  // Load mortgage data
  Future<Map<String, dynamic>> loadMortgageData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'loanAmount': prefs.getDouble(loanAmountKey) ?? 0.0,
      'interestRate': prefs.getDouble(interestRateKey) ?? 0.0,
      'loanTerm': prefs.getInt(loanTermKey) ?? 0,
      'monthlyPayment': prefs.getDouble(monthlyPaymentKey) ?? 0.0,
      'totalPayment': prefs.getDouble(totalPaymentKey) ?? 0.0,
    };
  }

  // Clear saved data
  Future<void> clearMortgageData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(loanAmountKey);
    await prefs.remove(interestRateKey);
    await prefs.remove(loanTermKey);
    await prefs.remove(monthlyPaymentKey);
    await prefs.remove(totalPaymentKey);
  }
}