import 'package:flutter/material.dart';
import 'package:login_bloc/bloc.dart';
import 'package:login_bloc/page2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Bloc',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = Bloc();

  changeThePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Page2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Pattern"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                  stream: bloc.email,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: bloc.emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Email",
                        labelText: "Email",
                        errorText: snapshot.error,
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<String>(
                  stream: bloc.password,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: bloc.passwordChanged,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                        labelText: "Password",
                        errorText: snapshot.error,
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<bool>(
                  stream: bloc.submitCheck,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      color: Colors.tealAccent,
                      onPressed: snapshot.hasData
                          ? () => changeThePage(context)
                          : null,
                      child: Text("Submit"),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
