import 'package:flutter/material.dart';
import 'dart:async';
import 'package:currency_convertor/widgets/currencies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uri? url;
  String? currencyValue;
  final textController = TextEditingController();

  double? currencyInUSD;
  double? currencyInINR;
  bool isLoading = false;

  Future<void> setCurrencyValue() async {
    setState(() {
      isLoading = true;
    });

    try {
      currencyInUSD = double.parse(textController.text);

      String currencyUrl =
          "https://api.currencyapi.com/v3/latest?apikey=cur_live_uqA272u3mMpTKHc86D1wtmDnLRxtRdTvXr01US9a";
      url = Uri.parse(currencyUrl);

      double currencyData = await CurrencyConversion(url: url!).getCurrency();
      String newCurrencyValue = currencyData.toStringAsFixed(2);

      setState(() {
        currencyInINR = currencyInUSD! * double.parse(newCurrencyValue);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text('USD'),
                      subtitle: Text('United States Dollar'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: textController,
                          decoration: InputDecoration(
                            hintText: "Enter the amount...",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () => textController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "₹$currencyInINR",
                                  style: const TextStyle(
                                      fontSize: 36, color: Colors.black),
                                ),
                        ),
                        const Column(
                          children: [
                            Text(
                              "INR",
                              style: TextStyle(
                                  color: Color(0xffBCBBC5), fontSize: 36),
                            ),
                            Text("INDIAN RUPEES",
                                style: TextStyle(
                                    color: Color(0xffBCBBC5),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: setCurrencyValue,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: const Text('Calculate'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
