import 'package:flutter/material.dart';
import 'package:flutter_app3/models/data.dart';
import 'package:flutter_app3/quizFinish.dart';

class QuizPage extends StatefulWidget {
  List<Data> data;
  QuizPage(this.data);
  @override
  _QuizPageState createState() => _QuizPageState(data);
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    Body();
  }

  List<Data> data;
  _QuizPageState(this.data);
  List question = [];
  List falseQuestion = [];
  int id = 0;
  var _formKey = GlobalKey<FormState>();
  var _reply = TextEditingController();
  int trueNum = 0;
  int falseNum = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Quiz"),
            automaticallyImplyLeading: false,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => quizFinish(falseQuestion,trueNum,falseNum,data)),
                      );
                    },
                    icon: Icon(Icons.exit_to_app_outlined)),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Kelime : ${question[id].kelime}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                          controller: _reply,
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontSize: 15),
                          autofocus: false,
                          validator: (kontroledilecekname) {
                            if (kontroledilecekname != question[id].karsilik) {
                              falseQuestion.add(question[id]);
                              falseNum++;
                              return null;
                            } else if (kontroledilecekname ==
                                question[id].karsilik) {
                              trueNum++;
                              return null;
                            } else if (kontroledilecekname!.isEmpty) {
                              return "Burası Boş Olamaz";
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            labelText: "Karşılığı",
                          )),
                    )),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          if (id == question.length - 1) {
                            print("hata");
                          } else {
                            _reply.clear();
                            id++;
                          }
                        }
                      });
                    },
                    child:
                        Text(id != question.length - 1 ? "Sonraki" : "Bitir")),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(falseNum.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    Text(trueNum.toString())
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Body() {
    for (var i = 0; i < data.length; i++) {
      if (data[i].isActive == 1) {
        question.add(data[i]);
      }
    }
  }
}
