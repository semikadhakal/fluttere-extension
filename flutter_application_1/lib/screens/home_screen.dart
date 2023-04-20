import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/task_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _formData = TextEditingController();
  String textValue = "";

  //  this list will contain all the todos
  List<Map<String, dynamic>> todoList = [];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(" kk:mm:ss \n EEE d MMM").format(now);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/flutterimage.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Afternoon, Semika",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "It's ${formattedDate}",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: _formData,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter an item",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    todoList.add({
                      "task": _formData.text,
                      "icon": Icons.task,
                      "checked": false,
                    });
                    _formData.text = "";
                    setState(() {});
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    var item = todoList[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                              value: item['checked'],
                              onChanged: (value) {
                                for (var i = 0; i < todoList.length; i++) {
                                  if (todoList[i] == item) {
                                    setState(() {
                                      todoList[i]['checked'] =
                                          !todoList[i]['checked'];
                                    });
                                  }
                                }
                              }),
                          GestureDetector(
                              onTap: () {
                                print("tap");
                                Get.to(
                                  TaskScreen(
                                    title: item['task'],
                                  ),
                                  transition: Transition.fade,
                                );
                              },
                              child: Text(item['task'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  )))
                          // Text("Course for 4th sem"),
                          // Icon(Icons.task_outlined),
                        ],
                      ),
                    );
                  },
                )
                // if(textValue != "")
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
