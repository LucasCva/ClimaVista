import 'package:clima_vista/data/http/http_client.dart';
import 'package:clima_vista/data/repositories/temperatura_repository.dart';
import 'package:clima_vista/screens/stores/stores_temperatura.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StoresTemperatura store = StoresTemperatura(
    repository: TemperaturaRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getTemperatura();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
          animation: Listenable.merge(
            [
              store.isLoading,
              store.state,
              store.error,
            ],
          ),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            } else {
              final temp = store.state.value?.temperatura.toString();
              final city = store.state.value?.cidade;

              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, screenHeight * 0.6, 0, 0),
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                  ),
                  Center(
                    child: Container(
                      width: screenWidht,
                      height: screenHeight,
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidht * 0.1,
                          vertical: screenHeight * 0.1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Color.fromARGB(255, 255, 226, 138),
                            Colors.white
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 25,
                                color: Color.fromARGB(255, 12, 55, 112),
                              ),
                              Text(
                                ' $city',
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 12, 55, 112),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenHeight * 0.09, 0, 0),
                            child: const Icon(
                              Icons.sunny,
                              size: 220,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0, screenHeight * 0.07, 0, 0),
                            child: RichText(
                              text: TextSpan(
                                text: '$temp',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 12, 55, 112),
                                  fontSize: 120,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '°',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 12, 55, 112),
                                      fontSize: 120,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -40.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
