import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> CountProvider()),
        ChangeNotifierProvider(create: (_)=> FormProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    context.read<CountProvider>().increase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Insert your name in English.',
                contentPadding: EdgeInsets.fromLTRB(5, 10, 20, 4),
              ),
              onChanged: (String str) {
                context.read<FormProvider>().changeName(str);
              },
            ),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Insert your age.',
                contentPadding: EdgeInsets.fromLTRB(5, 10, 20, 4),
              ),
              onChanged: (String str) {
                context.read<FormProvider>().changeAge(str);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Insert your phone number.',
                contentPadding: EdgeInsets.fromLTRB(5, 10, 20, 4),
              ),
              onChanged: (String str) {
                context.read<FormProvider>().changePhone(str);
              },
            ),
            Text("???????????? ${context.select((FormProvider p) => p.age)}?????? ${context.select((FormProvider p) => p.name)} ?????????. "),
            const Text("????????? ?????? ???????????? ???????????????, ????????? ???????????? ????????????."),
            FlatButton(onPressed: (){
              Navigator.pop(context, MaterialPageRoute(builder: (BuildContext context){
                return const SecondScreen();
              }));
            },
                child: Container(
                  color: Colors.blue,
                  child: const Text("?????? ?????????"))),
            FlatButton(onPressed: (){
              context.read<FormProvider>().resetMBTI();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return const SecondScreen();
              }));
            },
                child: Container(
                  color: Colors.red,
                  child: const Text("?????? ?????????"))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CountProvider with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increase() {
    _count++;
    notifyListeners();
  }

  void decrease() {
    _count--;
    notifyListeners();
  }
}

class FormProvider with ChangeNotifier {
  String _name = "";
  String _phone = "";
  String _MBTI = "";
  int _age = 0;

  int get age => _age;
  String get phone => _phone;
  String get name => _name;
  String get MBTI => _MBTI;

  void changeName(String str) {
    _name = str;
    notifyListeners();
  }

  void changePhone(String str) {
    _phone = str;
    notifyListeners();
  }

  void changeAge(String str) {
    _age = int.parse(str);
    notifyListeners();
  }

  void addMBTI(String str) {
    _MBTI  = _MBTI + str;
    notifyListeners();
  }

  void resetMBTI() {
    _MBTI = "";
    notifyListeners();
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          const Text("?????? ?????? ?????? ????????? ?????????????"),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://res.klook.com/image/upload/v1617101647/blog/edlhmuf96dpqcnodl9qf.jpg"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("E");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const ThirdScreen();
            }));
          },
              child: Container(
                  color: Colors.greenAccent,
                  child: const Text("?????????, ???????????? ?????? ??????"))),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://enewstoday.co.kr/news/photo/202003/1372581_434462_148.jpg"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("I");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const ThirdScreen();
            }));
          },
              child: Container(
                  color: Colors.amber,
                  child: const Text("????????? ??????, TV ??????"))),
        ],
      )),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          const Text("????????? ????????? ?????? ??? ?????? ?????? ????????? ?????????????"),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://bit.ly/3Mn4oFi"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("S");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const FourthScreen();
            }));
          },
              child: Container(
                  color: Colors.deepOrangeAccent,
                  child: const Text("????????? ???????????? ?????? ???????????? ?????? ?????? ??? ??? ?????? ??? ??????"))),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://content.skyscnr.com/m/77e9f436241cdd58/original/GettyImages-118344741.jpg?resize=1800px:1800px&quality=100"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("N");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const FourthScreen();
            }));
          },
              child: Container(
                  color: Colors.lightBlue,
                  child: const Text("???????????? ????????? ?????? ??????????????? ??????, ?????? ????????? ?????? ??????"))),
        ],
      )),
    );
  }
}

class FourthScreen extends StatelessWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          const Text("????????? ????????? ??????????????? ?????? ?????? ????????? ?????????????"),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://t1.daumcdn.net/cfile/tistory/0226E34F51A1BB2922"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("F");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const FifthScreen();
            }));
          },
              child: Container(
                  color: Colors.greenAccent,
                  child: const Text("\"?????????... ????????????.. ?????? ?????? ??? ????????? ??????!\""))),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://ar.justinfeed.com/img/images/20-deep-questions-to-ask-your-best-friend-and-strengthen-your-bond.jpg"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("T");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const FifthScreen();
            }));
          },
              child: Container(
                  color: Colors.amber,
                  child: const Text("\"?????? ????????? ????????? ??????? ??? ????????? ??? ???????\""))),
        ],
      )),
    );
  }
}

class FifthScreen extends StatelessWidget {
  const FifthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          const Text("?????? ??? ?????? ????????? ?????? ?????? ??? ????????? ??????????"),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://bit.ly/3wgH7iB"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("P");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const FinalScreen();
            }));
          },
              child: Container(
                  color: Colors.lime,
                  child: const Text("????????? ?????? ??? ???????????? ?????? ?????? ?????? ????????????."))),
          Container(
            width: 350,
            height: 250,
            child: Image.network("https://t1.daumcdn.net/cfile/blog/276DDC3B559A088901"),
          ),
          FlatButton(onPressed: (){
            context.read<FormProvider>().addMBTI("J");
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return const FinalScreen();
            }));
          },
              child: Container(
                  color: Colors.purpleAccent,
                  child: const Text("?????? ?????? ?????? ??? ????????? ????????? ?????? ?????? ?????? ???????????????."))),
        ],
      )),
    );
  }
}

class FinalScreen extends StatelessWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("???????????? ?????? ????????? ${context.select((FormProvider p) => p.MBTI)} ?????????. ")
        ],
      )),
    );
  }
}