import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stateless_as_stateful_widget/provider%20for%20text%20fields.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>name()),
      ChangeNotifierProvider(create: (_)=>password()),
      ChangeNotifierProvider(create: (_)=>theme()),
    ],
    child:  MaterialApp(
      home: xtra_class(),
    ),


    );
  }
}

class xtra_class extends StatefulWidget {
  const xtra_class({Key? key}) : super(key: key);

  @override
  _xtra_classState createState() => _xtra_classState();
}

class _xtra_classState extends State<xtra_class> {
  @override
  Widget build(BuildContext context) {
    final provider_theme = Provider.of<theme>(context);
    return MaterialApp(
      theme: provider_theme.get_theme,
      home: Screen(),
    );
  }
}




class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build called');
    final provider_name = Provider.of<name>(context,listen: false);
    final provider_password = Provider.of<password>(context,listen: false);
    final provider_theme = Provider.of<theme>(context,listen: false);
    ValueNotifier<bool> hide_password = ValueNotifier(true);


    return Scaffold(
        appBar: AppBar(

          title: Row(
            children: [
              Text('Stateless as stateful widget'),
              InkWell(
                onTap: (){
                  print("Before Theme change");
                  provider_theme.set_theme(provider_theme.get_theme);
                  print("Theme change");
                },
                child: Icon(Icons.wb_sunny),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Consumer<name>(
                  builder: (context,value,child){
                    print('Only text called');
                    return TextFormField(
                      onChanged: (value){
                        provider_name.set_name(value);
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 23,),
                  ValueListenableBuilder(
                    valueListenable: hide_password,
                    builder: (context,value,child){
                      return Expanded(
                        child: Consumer<password>(
                          builder: (context,value,child){
                            print("Only password called");
                            return TextFormField(
                              obscureText: hide_password.value,
                              onChanged: (value){
                                provider_password.set_password(value);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  )
                              ),
                            );
                          },
                        ),
                      );
                    },

                  ),
                  SizedBox(width: 10,),
                  ValueListenableBuilder(
                    valueListenable: hide_password,
                    builder: (context,value,child){

                      return InkWell(
                        onTap: (){

                          hide_password.value = !hide_password.value;

                        },
                        child: hide_password.value ? Icon(Icons.remove_red_eye):Icon(Icons.hide_source) ,
                      );

                    },
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 40,),
              MaterialButton(
                height: 67,
                minWidth: 300,
                color: Colors.lightGreenAccent,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(width:2,color:Colors.transparent),
                ),
                onPressed: (){
                  FlutterToastr.show(
                      "SUCCESFULLY LOGGED IN",
                      context,
                      duration: FlutterToastr.lengthLong,
                      position:  FlutterToastr.bottom);
                },
              child: Text('Login',style: TextStyle(fontSize: 20),),
              )

            ],
          ),
        )
    );
  }
}


