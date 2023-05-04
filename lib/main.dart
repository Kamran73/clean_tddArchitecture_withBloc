import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/controllers/count_controller/count_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CountController();
      },
      child: const MaterialApp(
        home: Stateless(),
      ),
    );
  }
}

class CountApp extends StatefulWidget {
  const CountApp({Key? key}) : super(key: key);

  @override
  State<CountApp> createState() => _CountAppState();
}

class _CountAppState extends State<CountApp> {
  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    CountController controller =
        Provider.of<CountController>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateValue();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<CountController>(
            builder: (context, value, child) {
              return Text('${controller.getCount}');
            },
          ),
          Consumer<CountController>(
            builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          value.removeAt(index: index);
                        },
                        icon: const Icon(Icons.cancel_outlined),
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        value.getList[index].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  },
                  itemCount: value.getList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Stateless extends StatelessWidget {
  const Stateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    ValueNotifier<int> count = ValueNotifier<int>(0);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count.value++;
          debugPrint(count.value.toString());
        },
      ),
      body: Center(
        child: ValueListenableBuilder(
          builder: (context, value, child) {
            return Text(
              count.value.toString(),
              style: const TextStyle(fontSize: 20),
            );
          }, valueListenable: count,
        ),
      ),
    );
  }
}
