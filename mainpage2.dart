import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String title = 'SharedPreferences';
Future<SharedPreferences> prefs = SharedPreferences.getInstance();
// ignore: non_constant_identifier_names
final TextEditingController PhoneNumberController = TextEditingController();
// ignore: non_constant_identifier_names
String PhoneNumber;
var finalPhoneNumber;
void main() => runApp(
      MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        home: sharedpreferences(),
      ),
    );

// ignore: camel_case_types
class sharedpreferences extends StatefulWidget {
  @override
  _sharedpreferencesState createState() => _sharedpreferencesState();
}

// ignore: camel_case_types
class _sharedpreferencesState extends State<sharedpreferences> {
  // ignore: non_constant_identifier_names
  Future get_phoneNumber() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    //we can get the phonenuber value from this 'phoneNumber 'token
    //and we created an dup obtainedPhoneNumber and got that from finalPhoneNumber
    var obtainedPhoneNumber = sharedPreferences.getString(
      'phoneNumber',
    );

    setState(() {
      finalPhoneNumber = obtainedPhoneNumber;
      print(finalPhoneNumber);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_phoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: TextField(
              text: finalPhoneNumber == ''
                  ? 'Enter PhoneNumber'
                  : finalPhoneNumber,
              value: PhoneNumber,
            )),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: SubmitButton(
                colour: Colors.blueGrey,
                onPress: () {
                  // ignore: non_constant_identifier_names, missing_return
                  Future<int> Set_PhoneNumber() async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    //here we passing the PhoneNumber to this "phoneNumber" token
                    //now we can get the store value by using this "phoneNumber" token
                    sharedPreferences.setString(
                        'phoneNumber', PhoneNumberController.text);
                    print('from $PhoneNumberController');
                  }

                  setState(() {
                    Set_PhoneNumber();
                  });
                },
                text: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  TextField({@required this.text, @required this.value});
  final value;
  final text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return text;
          }
          return null;
        },
        controller: PhoneNumberController,
        textAlign: TextAlign.center,
        onChanged: (value) {
          value = value;
        },
        decoration: kTextFieldDecoration.copyWith(hintText: text),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton(
      {@required this.colour, @required this.onPress, @required this.text});
  final colour;
  final onPress;
  final text;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colour,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: onPress,
        minWidth: 200,
        height: 40.0,
        child: Text(
          text,
          style: kOnpressTextStyle,
        ),
      ),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  hintText: 'hintText',
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
);
const kOnpressTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
  fontWeight: FontWeight.w300,
  letterSpacing: 1.0,
);
