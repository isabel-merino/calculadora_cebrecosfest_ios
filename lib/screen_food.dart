import 'package:flutter/material.dart';
import 'data.dart';
import 'global_variable.dart';
//import 'package:provider/provider.dart';

class ScreenFoods extends StatefulWidget {
  const ScreenFoods({super.key});
  //required this.summ

  @override
  State<ScreenFoods> createState() => _ScreenFoods();
}

class _ScreenFoods extends State<ScreenFoods> {
  //late List<Product> comidas = Provider.preciosComida.comidas;
  late List<Product> comidas = preciosComida.comidas;

  @override
  void initState() {
    super.initState();
    GlobalVariables().summ;
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 13, 161),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 13, 161), //blue
          foregroundColor: Theme.of(context).colorScheme.onPrimary, //white
          title: const Text("BarrApp Cebrecos Fest"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header with total amount and price
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${GlobalVariables().summ}',
                        style:
                            const TextStyle(fontSize: 56, color: Colors.pink),
                      ),
                      const Icon(Icons.euro, color: Colors.pink, size: 56),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: comidas.length,
                    itemBuilder: (context, index) {
                      final product = comidas[index];
                      return Card(
                        color: Colors.tealAccent.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Imagen del producto
                              SizedBox(
                                height: 80,
                                child: Image.asset(product.imagePath,
                                    fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 8),
                              // Nombre del producto
                              Text(
                                product.name,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // Botones de contador
                              SizedBox(
                                width: double
                                    .infinity, // ocupa todo el ancho disponible
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Botón menos
                                    _buildButton(Icons.remove, () {
                                      setState(() {
                                        if (product.count > 0) {
                                          product.count--;
                                          GlobalVariables().summ -=
                                              product.price;
                                        }
                                      });
                                    }),
                                    // Contador
                                    Text(
                                      product.count.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    // Botón más
                                    _buildButton(Icons.add, () {
                                      setState(() {
                                        product.count++;
                                        GlobalVariables().summ += product.price;
                                      });
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
