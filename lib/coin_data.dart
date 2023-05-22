import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'USD',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=F7C20328-471B-41F5-8D2A-E6F3AEAA81FB'));

      if (response.statusCode == 200) {
        String data = response.body;
        var decoded = jsonDecode(data);
        double price = decoded['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }

    return cryptoPrices;
  }
}
