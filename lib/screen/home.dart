import 'dart:convert';

import 'package:app_flutter/form/addChambre.dart';
import 'package:app_flutter/model/Chambre.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<home> createState() => _home();
}

class _home extends State<home> with TickerProviderStateMixin{
  late int status = 0;
  late TabController _tabController;
  var nbrTab = 2;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: nbrTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Chambre>> getChambre() async {
    var data = await http.get(Uri.parse("http://localhost:8080/all"));
    var jsonData = json.decode(data.body);

    List<Chambre> liste = [];
    for (var e in jsonData) {

      Chambre employees = Chambre.fromJson(e);
      liste.add(employees);
    }
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: DefaultTabController(
        length: nbrTab,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.auto_awesome_sharp)),
                Tab(icon: Icon(Icons.star_border)),
              ],
            ),
            backgroundColor: Colors.orangeAccent,
            title: const Text("Pokemon"),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [

            ],
          ),
          body: SafeArea(
            child: TabBarView(
              controller: _tabController,
              children: [
                FutureBuilder<List<Chambre>>(
                  future: getChambre(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("numero chambre = ${snapshot.data![index].numero_chambre}"),
                            subtitle: Text("prix htva = ${snapshot.data![index].prix_htva} euros"),
                          );
                        }
                      );
                    } else {
                      return const Center(child: Icon(Icons.error));
                    }
                  }
                ),
                AddChambre(),
              ]
            )
          ),
        ),
      ),
    );
  }
}

