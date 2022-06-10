import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const baseApiUrl = 'https://rest.coinapi.io';
const apiKey = '4D852E87-6827-4109-B20F-15A6348445A9';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  String selectedCurrencyExchangeRate;
  @override
  void initState() {
    getExchangeRate();
    super.initState();
  }

  void getExchangeRate() async {
    Uri url = Uri.parse(
        '$baseApiUrl/v1/exchangerate/$selectedCrypto/$selectedCurrency?apikey=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      setState(() {
        int rate = jsonData['rate'].round();
        var formatedRate = NumberFormat("###,###.##", "en_US").format(rate);
        selectedCurrencyExchangeRate = formatedRate;
      });
    } else {
      return Future.error("Server Error");
    }
  }

  DropdownButton<String> getDropdownListItems() {
    List<DropdownMenuItem<String>> dropdownList = [];
    for (String currency in currenciesList) {
      var newDropdownItem = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
      dropdownList.add(newDropdownItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      onChanged: (selectedOption) {
        selectedCurrency = selectedOption;
        setState(() {
          getExchangeRate();
        });
      },
      items: dropdownList,
    );
  }

  Widget getPickerItems() {
    List<Text> cupertinoItems = [];
    for (var currency in currenciesList) {
      Text newItem = Text(
        currency,
        style: TextStyle(
          color: Colors.white,
        ),
      );
      cupertinoItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (onSelectedItemChanged) {},
      children: cupertinoItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCrypto = ${selectedCurrencyExchangeRate ?? "?"} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? getDropdownListItems() : getPickerItems(),
          ),
        ],
      ),
    );
  }
}
