import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() async {
  VSJApp vsjApp = VSJApp();
  await vsjApp.vsjHomePage.getWeather("Varanasi");
  runApp(vsjApp);
}

class VSJApp extends StatelessWidget {
  VSJHomePage vsjHomePage = VSJHomePage(title: 'Varanasi Software Junction');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Varanasi Software Junction',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: vsjHomePage,
    );
  }
}

class VSJHomePage extends StatefulWidget {
  //http://openweathermap.org/img/w/10d.png
  bool weatherfound = true;
  String currenticon = "";

  //*****************************************************************************************
  final String vsjurl =
      "https://3.bp.blogspot.com/-py5FbTZgvjo/YDi1bsQq16I/AAAAAAAACB0/BxejbJBcHA4AVfkB33WYC3YlVmxElM7BwCK4BGAYYCw/s1600/Varanasi%2BSoftware%2BJunction%2BPhone%2BLogo.png";
  String currenturl =
      "https://3.bp.blogspot.com/-py5FbTZgvjo/YDi1bsQq16I/AAAAAAAACB0/BxejbJBcHA4AVfkB33WYC3YlVmxElM7BwCK4BGAYYCw/s1600/Varanasi%2BSoftware%2BJunction%2BPhone%2BLogo.png";

  Future<bool> getWeather(String cityname) async {
    String apikey = "4a1f8a61b74546825af1e0be106e797b";
    final url = Uri.https("api.openweathermap.org", "/data/2.5/forecast",
        {'q': cityname, 'appid': apikey, 'units': 'metric'});

    try {
      final response = await http.get(url);

      print(response);
      print(response.statusCode);
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      print(jsonResponse.runtimeType);
      Map<String, dynamic> map = jsonResponse;
      print(map.keys);
      for (String key in map.keys) {
        dynamic value = map[key];
        print(key + " = " + value.toString());
      }
      print("icon" + map["list"][0]["weather"][0]["icon"].toString());
      currenticon = map["list"][0]["weather"][0]["icon"].toString();

      currentcitytemp = map["list"][0]["main"]["temp"].toString();
      currentmaxtemp = map["list"][0]["main"]["temp_max"].toString();
      currentmintemp = map["list"][0]["main"]["temp_min"].toString();
      description = map["list"][0]["weather"][0]["description"].toString();
      weatherfound = true;

      return true;
    } catch (ex) {
      print(ex);
      weatherfound = false;
      currentcitytemp = "-";
      currentmaxtemp = "-";
      currentmintemp = "-";
      description = "-";
      return false;
    }
  }

  //*****************************************************************************************
  VSJHomePage({Key? key, required this.title}) : super(key: key);
  final TextEditingController _controller =
  TextEditingController(text: 'Varanasi');
  String getTitle() {
    return "VSJ - Weather API: ";
  }

  String cityname = "Varanasi";
  String currentcitytemp = "-",
      currentmaxtemp = "-",
      currentmintemp = "-",
      description = "-";

  MainAxisAlignment mainaxisalignment = MainAxisAlignment.start;
  final String title;
  String display = "Varanasi Software Junction";

  final TextStyle datatextstyle = TextStyle(
    fontSize: 16,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.blue[700]!,
  );
  final TextStyle datalabelstyle = TextStyle(
    fontSize: 16,
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.teal[700]!,
  );

  @override
  _VSJPageState createState() => _VSJPageState();
}

class _VSJPageState extends State<VSJHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.getTitle()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("City Name: ", style: widget.datalabelstyle),
              Expanded(
                  flex: 2,
                  child: TextField(
                      controller: widget._controller,
                      style: widget.datatextstyle,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter the city name',
                      ),
                      onChanged: (text) {
                        widget.cityname = text;
                      })),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text("Get Weather"),
                      onPressed: () async {
                        await widget.getWeather(widget.cityname);
                        setState(() {});
                      },
                    ),
                  )),
            ]),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Current Temp", style: widget.datalabelstyle),
                          Text(widget.currentcitytemp, style: widget.datatextstyle),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Max Temp", style: widget.datalabelstyle),
                          Text(widget.currentmaxtemp, style: widget.datatextstyle),
                        ], //Children
                      ), //Column
                    ), //Padding
                  ), //Expanded
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Min Temp", style: widget.datalabelstyle),
                          Text(widget.currentmintemp, style: widget.datatextstyle),
                        ], //Children
                      ), //Column
                    ), //Padding
                  ), //Expanded
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Description", style: widget.datalabelstyle),
                          Text(widget.description, style: widget.datatextstyle),
                        ], //Children
                      ), //Column
                    ), //Padding
                  ), //Expanded
                ] //
                ),
              )),
          Expanded(
            child: Card(
                shadowColor: Colors.black,
                elevation: 5,
                child: Image.network(
                  (widget.weatherfound)
                      ? "https://openweathermap.org/img/w/${widget.currenticon}.png"
                      : widget.currenturl,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }
}
