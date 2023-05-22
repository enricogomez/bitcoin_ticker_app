import 'package:bitcoin_ticker_app/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = currenciesList[0];
  Map<String, String> rate = {
    'BTC': '0',
    'ETH': '0',
    'LTC': '0',
  };

  void getCurrencyData(String currency) async {
    dynamic newData = await coinData.getCoinData(selectedCurrency);

    setState(() {
      selectedCurrency = currency;
      rate = newData;
    });
  }

  @override
  void initState() {
    getCurrencyData(selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (String cryptoItem in cryptoList)
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 $cryptoItem = ${rate[cryptoItem]} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? CupertinoPicker(
                    itemExtent: 30.0,
                    onSelectedItemChanged: (index) {
                      getCurrencyData(currenciesList[index]);
                    },
                    children: [
                      for (String currency in currenciesList) Text(currency),
                    ],
                  )
                : DropdownButton<String>(
                    value: selectedCurrency,
                    items: [
                      for (String coin in currenciesList)
                        DropdownMenuItem<String>(
                          value: coin,
                          child: Text(coin),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        getCurrencyData(value);
                      }
                    },
                  ),
          )
        ],
      ),
    );
  }
}
