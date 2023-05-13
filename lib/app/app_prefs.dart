import 'package:flutter_advanced/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String PREFS_KEY_LANGUAGE="PREFS_KEY_LANGUAGE";
class AppPreferences{

   final SharedPreferences _sharedPreferences;
   AppPreferences(this._sharedPreferences);

   String getAppLanguage(){
      String? language=_sharedPreferences.getString(PREFS_KEY_LANGUAGE);
      if(language !=null && language.isNotEmpty){
         return language;
      }else{
         return LanguageType.ENGLISH.getValue();
      }
   }
}