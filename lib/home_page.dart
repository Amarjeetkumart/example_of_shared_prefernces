import 'package:flutter/material.dart';
import 'package:students_data/shared_prefernces_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  bool _isStudent = false;

  String _name = "";
  int _age = 0;
  double _height = 0.0;
  bool _isStudentSeved = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _saveData() async {
    await SharedPreferncesHelper.saveString("name", _nameController.text);
    await SharedPreferncesHelper.saveInt(
      "age",
      int.parse(_ageController.text),
    );
    await SharedPreferncesHelper.saveDouble(
      "height",
      double.parse(_heightController.text),
    );
    await SharedPreferncesHelper.saveBool("isStudent", _isStudent);
    _loadData();
  }

  Future<void> _loadData() async {
    String? name = await SharedPreferncesHelper.loadString("name");
    int? age = await SharedPreferncesHelper.loadInt("age");
    double? height = await SharedPreferncesHelper.loadDouble("height");
    bool? isStudent = await SharedPreferncesHelper.loadBool("isStudent");

    setState(() {
      _name = name ?? "";
      _age = age ?? 0;
      _height = height ?? 0.0;
      _isStudentSeved = isStudent ?? false;
      _nameController.text = _name;
      _ageController.text = _age.toString();
      _heightController.text = _height.toString();
      _isStudent = _isStudentSeved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences Example"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              //Colors.purple,
              Color.fromARGB(90, 238, 240, 248),
              // Colors.purpleAccent,
              Color.fromARGB(255, 213, 209, 224),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Enter Your name"),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: "Enter Your age"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _heightController,
                decoration:
                    const InputDecoration(labelText: "Enter Your height"),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                children: [
                  const Text("Are You a Student?"),
                  Checkbox(
                      value: _isStudent,
                      onChanged: (value) {
                        setState(() {
                          _isStudent = value!;
                        });
                      })
                ],
              ),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text("Save Data"),
              ),
              const SizedBox(height: 20),
              Text("Save name: $_name"),
              Text("Save Age: $_age"),
              Text("Save Height: $_height"),
              Text("is Student: $_isStudentSeved"),
            ],
          ),
        ),
      ),
    );
  }
}
