import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class name with ChangeNotifier{

  String _name = "";

  
  get get_name => _name;

  
  set_name(value){
    _name=value;
    notifyListeners();
  }

}


class password with ChangeNotifier{

  String _password = "";

  get get_password => _password;

  set_password(value){
    _password=value;
    notifyListeners();
  }

}

class theme with ChangeNotifier{

  ThemeData present_theme = ThemeData.light();

  get get_theme=> present_theme;

  set_theme(ThemeData themee){


    bool isDark = themee==ThemeData.dark();

    if(isDark){
      present_theme = ThemeData.light();
      notifyListeners();
    }
    else if(!isDark){
      present_theme = ThemeData.dark();
      notifyListeners();
    }

  }

}
