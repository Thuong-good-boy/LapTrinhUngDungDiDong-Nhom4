import 'package:flutter/material.dart';
class BaiTap2 extends StatefulWidget {
  const BaiTap2({super.key});

  @override
  State<BaiTap2> createState() => _BaiTap2State();
}

class _BaiTap2State extends State<BaiTap2> {
  List anh = [
    "assets/images/laudai.jpg",
    "assets/images/nhatho.jpg",
    "assets/images/nhatho2.jpg",
    "assets/images/nhatho3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Icon(Icons.notifications, size: 30.0),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Icon(Icons.extension, size: 30.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 50.0),
                    children: const [
                      TextSpan(
                        text: "Welcome,\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "Charlie",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 20.0),
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    contentPadding: EdgeInsets.all(10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Saved Places",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: anh.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      anh[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
