import 'dart:convert';
import 'package:http/http.dart' as http;

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
const apiKey = '4D852E87-6827-4109-B20F-15A6348445A9';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    // ignore: todo
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    // ignore: todo
    //TODO 5: Return a Map of the results instead of a single value.
    Map<String, String> criptoPrices = {};
    for (var crypto in cryptoList) {
      Uri requestURL =
          Uri.parse('$coinAPIURL/$crypto/$selectedCurrency/?apiKey=$apiKey');
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        criptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        throw 'Problem with the get request';
      }
    }
    return criptoPrices;
  }
}
