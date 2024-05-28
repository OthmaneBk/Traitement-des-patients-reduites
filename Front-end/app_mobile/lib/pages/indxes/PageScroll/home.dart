import 'package:app_mobile/pages/MVC/models/PasParJour.dart';
import 'package:app_mobile/pages/MVC/models/PatientData.dart';
import 'package:flutter/material.dart';
import '../../MVC/Controller/Controller.dart';
import '../../MVC/models/Patient.dart';
import '../Categories/Seance_Reduction/seance_red.dart';
import '../Categories/SuivActivite/TEST/graphePas.dart';
import '../Categories/SuivActivite/suiv_act.dart';
import '../Categories/rappel_medica/rapp_med.dart';
import 'Notifications/rendezvous.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController=ScrollController();

  List<Map<String, dynamic>> medCat=[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScroll= scrollController.position.minScrollExtent;
      double maxScroll=scrollController.position.maxScrollExtent;

      animateToMaxMin(maxScroll,minScroll,maxScroll,10,scrollController);

    });
  }

  animateToMaxMin(double max, double min, double direction,int seconds, ScrollController scrollController){
    scrollController.
    animateTo(direction, duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
          direction=direction==max ? min :max;
          animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Patient patient = PatientData().patient;
    return Scaffold(
      body:Stack(
        children: [SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children:  <Widget>[
                            Text(
                                'Bonjour ${patient.nomutilisateur}',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            SizedBox(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/images/photo.png'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 140,
                        child: ListView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            TextButton(
                                onPressed: (){},
                                child: Text("Affrontez chaque \npas avec confiance")
                            ),
                            TextButton(
                                onPressed: (){},
                                child: Text("Prenez soin \nde vous")
                            ),
                            TextButton(
                                onPressed: (){},
                                child: Text("Nourrissez votre\n équilibre")
                            ),
                            TextButton(
                                onPressed: (){},
                                child: Text("Continuez à\n gagner")
                            ),TextButton(
                                onPressed: (){},
                                child: Text("tu es tres\n fort")
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text(
                          " Categories",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      child:TextButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return RappMed();
                                              }
                                          ));
                                        },
                                        child: Image.asset(
                                            "assets/images/RappelMEed.jpg",
                                            height: 130,
                                            width: 170,
                                          ),
                                      ),
                                  ),
                                  Text("Rappel de médicament",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              //Text("Rappel de medicament"),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Container(
                                        child: TextButton(
                                          onPressed: ()async{
                                            Map<String, int>? nombreDePas = await DataSuiveActivite(patient.nomutilisateur);
                                            PasParJour().setPasJour(nombreDePas!);
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                  return Graphepas();
                                                }
                                            ));
                                          },
                                          child: Image.asset(
                                              "assets/images/SuiveAct.jpg",
                                              height: 130,
                                              width: 170,
                                          ),
                                        )),
                                    Text("Pas quotidienne",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child:TextButton(
                                      onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                    return SeanceRed();
                                                }
                                              ));
                                            },
                                      child: Image.asset(
                                        "assets/images/Reduction.jpg",
                                        height: 130,
                                        width: 170,
                                      ),
                                    ),
                                  ),
                                  Text("Seance de réduction",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Container(
                                        child: TextButton(
                                          onPressed: (){ Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return RendezVous();
                                              }
                                          ));
                                          },
                                          child: Image.asset(
                                            "assets/images/NoteMed.jpg",
                                            height: 130,
                                            width: 170,
                                          ),
                                        )),
                                    Text("Rendez-vous avec Medecin",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
        ],
      )
    );
  }
}
