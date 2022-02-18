import 'package:currency_ticker/api_connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin.dart';
import 'api_connect.dart';
import 'displays.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int selectedCurrencyIndex = 0;
  var resBTC;
  var resETH;
  var resLTC;
  String selectedBaseSymbol = 'AUD';

  List<Text> getCurrencyList() {
    List<Text> currencyList = [];
    for (String curr in currenciesList) {
      currencyList.add(
        Text(
          curr,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return currencyList;
  }

  Future<dynamic> getBTC({required base}) async {
    var getBTCValue = await APIConnect().getAPIResults(
      baseCurrency: base,
      targetCurrency: 'BTC',
    );
    print(getBTCValue);
    setState(() {
      resBTC = getBTCValue['rate'].round();
    });
  }

  Future<dynamic> getETH({required base}) async {
    var getETHValue = await APIConnect().getAPIResults(
      baseCurrency: base,
      targetCurrency: 'ETH',
    );
    setState(() {
      resETH = getETHValue['rate'].round();
    });
  }

  Future<dynamic> getLTC({required base}) async {
    var getLTCValue = await APIConnect().getAPIResults(
      baseCurrency: base,
      targetCurrency: 'LTC',
    );
    setState(() {
      resLTC = getLTCValue['rate'].round();
    });
  }

  @override
  void initState() {
    super.initState();
    getBTC(base: selectedBaseSymbol);
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
            child: Column(
              children: [
                DisplayResults(
                    label: 'BTC',
                    apiResult: resBTC,
                    selectedBaseSymbol: selectedBaseSymbol),
                DisplayResults(
                    label: 'ETH',
                    apiResult: resETH,
                    selectedBaseSymbol: selectedBaseSymbol),
                DisplayResults(
                    label: 'LTC',
                    apiResult: resLTC,
                    selectedBaseSymbol: selectedBaseSymbol),
              ],
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32,
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
                    selectedBaseSymbol = currenciesList[selectedIndex];
                  });
                  getBTC(base: selectedBaseSymbol);
                  getETH(base: selectedBaseSymbol);
                  getLTC(base: selectedBaseSymbol);
                },
                children: getCurrencyList(),
              )),
        ],
      ),
    );
  }
}
