import 'package:currency_convertor/widgets/currencies.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late Uri url;
String CurrencyValue = '';
bool isLoading = true;

class _HomePageState extends State<HomePage> {
  Future<void> setCurrencyValue() async {
    String currencyUrl =
        "https://api.currencyapi.com/v3/latest?apikey=cur_live_uqA272u3mMpTKHc86D1wtmDnLRxtRdTvXr01US9a";
    url = Uri.parse(currencyUrl);
    try {
      double currencyData = await CurrencyConversion(url: url).getCurrency();
      String newCurrencyValue = currencyData.toStringAsFixed(2);

      setState(() {
        CurrencyValue = newCurrencyValue;
        isLoading = false;
      });
    } on Exception {
      isLoading = false;
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    setCurrencyValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffedf2f4),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Text(
                      "🇺🇸",
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text('USD'),
                    subtitle: Text('United States Dollar'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '1.00',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Text(
                      "🇮🇳",
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text('INR'),
                    subtitle: Text('Indian Rupees'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            CurrencyValue,
                            style: const TextStyle(
                                fontSize: 36, color: Colors.black),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
