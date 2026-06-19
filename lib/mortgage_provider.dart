import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MortgageProvider extends ChangeNotifier {
  // Store variables
  double amount = 200000.0;
  int years = 30;
  double rate = 5.0;
  double monthlyPayment = 0.0;
  double totalPayment = 0.0;

  MortgageProvider() {
    loadData();
  }

  // Update Mortgage Logic (Standard Amortization Formula)
  void updateMortgage() {
    double monthlyRate = rate / 100 / 12;
    int numberOfPayments = years * 12;

    if (monthlyRate > 0) {
      monthlyPayment = amount *
          (monthlyRate * pow(1 + monthlyRate, numberOfPayments)) /
          (pow(1 + monthlyRate, numberOfPayments) - 1);
    } else {
      monthlyPayment = amount / numberOfPayments;
    }
    totalPayment = monthlyPayment * numberOfPayments;

    notifyListeners();
  }

  // Save data using SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('mortgage_amount', amount);
    await prefs.setInt('mortgage_years', years);
    await prefs.setDouble('mortgage_rate', rate);
  }

  // Load data using SharedPreferences
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    amount = prefs.getDouble('mortgage_amount') ?? 200000.0;
    years = prefs.getInt('mortgage_years') ?? 30;
    rate = prefs.getDouble('mortgage_rate') ?? 5.0;
    
    updateMortgage(); // Recalculate on load
  }

  // Helper to update values from UI
  void updateValues(double newAmount, int newYears, double newRate) {
    amount = newAmount;
    years = newYears;
    rate = newRate;
    updateMortgage();
    saveData();
  }
}