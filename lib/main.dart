import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ToDoApp());
}


class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  void didChangeDependencies() async {
    final response = await FirebaseFirestore.instance.collection("todo").get();
    print(response);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('todo').get(),
        builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            final list = snapshot.data?.docs.toList();
            print(list);
            if(list != null) {
              return ListView.builder(
                  itemBuilder: (_, index) {
                    return Text(
                      list[index].data()['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
              itemCount: list.length,
              );
            }
            return const SizedBox();
          } else {
            return const Center(child: CircularProgressIndicator());
          }

        },
      )

      
    );
  }
}