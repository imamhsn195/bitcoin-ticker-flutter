// ignore: todo
//TODO: Add your imports here.
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

const List<String> currenciesList = [
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
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '411E3C6E-94C3-4356-A8DB-2F4EEC47A458';

class CoinData {
  // ignore: todo
  //TODO: Create your getCoinData() method here.
  Future<dynamic> getCoinData(selectedCurrency) async {
    Uri url = Uri.parse('$coinAPIURL/BTC/$selectedCurrency?apiKey=$apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = convert.jsonDecode(response.body);
      double rate = decodedData['rate'];
      return NumberFormat("###,###.0#", 'en_US').format(rate);
    } else {
      throw "Server error!";
    }
  }
}
