import 'package:currency_conversion/admin/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_conversion/theme/theme_provider.dart';
import 'package:currency_conversion/admin/manage_users.dart';
import 'package:currency_conversion/admin/currency_list.dart';
import 'package:currency_conversion/admin/currency_news.dart';
import 'package:currency_conversion/admin/user_feedback.dart';
import 'package:currency_conversion/admin/setting.dart';
import 'package:currency_conversion/auth/login.dart';
import 'package:currency_conversion/auth/register.dart';
import 'package:currency_conversion/auth/forgotpassword.dart';
import 'package:currency_conversion/user/home.dart';
import 'package:currency_conversion/user/currency_conversion.dart';
import 'package:currency_conversion/user/rate_alerts.dart';
import 'package:currency_conversion/user/help_center.dart';
import 'package:currency_conversion/user/currency_news.dart';
import 'package:currency_conversion/user/user_feedback.dart';
import 'package:currency_conversion/user/app_notification.dart';
import 'package:currency_conversion/user/settings.dart';
import 'package:currency_conversion/user/user_history.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const CurrencyApp()),
      );
}

class CurrencyApp extends StatelessWidget {
  const CurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
    theme: themeProvider.themeData,
      // initialRoute: '/login',
      routes: {
        // "/" : (context) => Homescreen(),
      '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
       "/admindashboard" : (context) => AdminDashboard(),
        "/currencylist" : (context) => CurrencyList(), 
        "/ManageUsers" : (context) => ManageUsers(),
        "/CurrencyNews" : (context) => CurrencyNews(),
        "/UserFeedback" : (context) => UserFeedback(),
        "/Settings" : (context) => Settings(),
        "/forgot": (context) => ForgotScreen(),
        "/userhome": (context) =>  UserHome(),
        "/currencyconversion": (context) => CurrencyConversionScreen(),
        "/ratealerts": (context) => RateAlerts(),
        "/support": (context) => UserSupportScreen(),
        "/usermarkettrend": (context) => MarketTrendScreen(),
        "/feedback": (context) => UserFeedbackScreen(),
        "/notifications": (context) => NotificationScreen(),
        "/usersettings": (context) => SettingsScreen(),
        "/userhistory" : (context) => UserHistory(),

       
      },
    //  home: const  UserHome(),
      home: CurrencyNews(),
      // home: CurrencyNews(),
      // home: const CurrencyList(),
    );
  }
}
