import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = "USD";
  List<DropdownMenuItem<String>> getDropdownListItems() {
    List<DropdownMenuItem<String>> dropdownList = [];
    for (String currency in currenciesList) {
      var newDropdownItem = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
      dropdownList.add(newDropdownItem);
    }
    return dropdownList;
  }

  List<Text> getPickerItems() {
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
    return cupertinoItems;
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
                  '1 BTC = ? USD',
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
            child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                onSelectedItemChanged: (onSelectedItemChanged) {},
                children: getPickerItems()),
          ),
        ],
      ),
    );
  }
}
// DropdownButton(
//   value: selectedValue,
//   onChanged: (selectedOption) {
//     setState(() {
//       selectedValue = selectedOption;
//     });
//   },
//   items: getDropdownListItems(),
// )