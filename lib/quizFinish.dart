import 'package:flutter/material.dart';

class quizFinish extends StatelessWidget {
  var falseQuestion = <Map<String,dynamic>>[];
  int trueNum;
  int falseNum;
  List selectedUsers = [];
  quizFinish(this.falseQuestion, this.trueNum, this.falseNum);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icon(Icons.chevron_left_rounded)),
        title: Text("Quiz Finali"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Doğru Sayın",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  trueNum.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Yanlış Sayın",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  falseNum.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  "Yanlış Bildiğin Kelimeler",
                  style: TextStyle(fontSize: 15),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 500,
                  child: ListView.builder(
                      itemCount: falseQuestion.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(falseQuestion[index]["kelime"] ,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(falseQuestion[index]["hata"],
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  trailing: Text(falseQuestion[index]["karsilik"],
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
