import 'package:flutter/material.dart';
import 'package:sqflite_mvp_login/data/database_helper.dart';
import 'package:sqflite_mvp_login/model/user_model';
import 'package:sqflite_mvp_login/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract{

  BuildContext _ctx;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState(){
    _presenter = new LoginPagePresenter(this);
  }

  void _submit(){
    final form = formKey.currentState;

    if(form.validate()){
      setState(() {
        _isLoading = true;
        form.save();
        
      });
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackbar(String text){
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text)
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(onPressed: _submit, child: new Text("Login"), color: Colors.green,);
    var loginForm = new Column(
    
      children: <Widget>[
      new Text("Sqflite app login", textScaleFactor: 2.0,),
      new Form(key: formKey, child: new Column(children: <Widget>[
        new Padding(padding: const EdgeInsets.all(10.0),
        child: new TextFormField(
          onSaved: (val) => _username = val,
          decoration: new InputDecoration(labelText: "Username"),
        )),

        new Padding(padding: const EdgeInsets.all(10.0),
        child: new TextFormField(
          onSaved: (val) => _password = val,
          decoration: new InputDecoration(labelText: "Password"),
        ),),

      ],),
      ),
      loginBtn
    ],
    crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: AppBar(title: new Text("Login Page"),),
      key: scaffoldKey,
      body: new Container(
        child: Center(
          child: loginForm,
        )
      ),
      
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError

    _showSnackbar(error.toString());

    setState(() async{
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) {
    // TODO: implement onLoginSuccess

    _showSnackbar(user.username.toString());
    setState(() {
      _isLoading = false;
    });

      var db = new DataBaseHelper();
      db.saveUser(user); 
      Navigator.of(context).pushNamed('/home');
  }
}