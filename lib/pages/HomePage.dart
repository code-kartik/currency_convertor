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
String currencyInUSD = '';
double currencyInINR = 0;
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffedf2f4),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Text(
                        "🇺🇸",
                        style: TextStyle(fontSize: 24),
                      ),
                      title: Text('USD'),
                      subtitle: Text('United States Dollar'),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: "Enter the amount...",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () => TextEditingController().clear(),
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Expanded(
              child: Card(
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
                              currencyInINR.toString(),
                              style: const TextStyle(
                                  fontSize: 36, color: Colors.black),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
