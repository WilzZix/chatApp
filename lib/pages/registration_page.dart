import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/db_service.dart';
import 'package:chat_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  GlobalKey<FormState>? _formKey;
  AuthProvider _auth = AuthProvider();
  String? _name;
  String? _email;
  String? _password;

  _RegistrationPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: signupPageUI(),
        ),
      ),
    );
  }

  Widget signupPageUI() {
    return Builder(builder: (BuildContext context) {
      _auth = Provider.of(context);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingWidget(),
            _inputForm(),
            _loginButton(),
            _backToLoginPageButton(),
          ],
        ),
        height: _deviceHeight * 0.75,
      );
    });
  }

  Widget _headingWidget() {
    return SizedBox(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Lets get going',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            'Please enter your details.',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return SizedBox(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey!.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageSelectorWidget(),
            _nameTextField(),
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: _deviceHeight * 0.10,
        width: _deviceWidth * 0.10,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(500),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://media.istockphoto.com/vectors/programming-design-concept-vector-id947663966?b=1&k=20&m=947663966&s=170x170&h=JoiK3tnziP5tqqABhc_iDFj9oW2QAZqLpMO2QKpB4G0='),
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.isNotEmpty ? null : "Please enter a name";
      },
      onSaved: (_input) {
        _name = _input;
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        hintText: 'Name',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.isNotEmpty && _input.contains("@")
            ? null
            : "Please enter a valid email";
      },
      onSaved: (_input) {
        _email = _input;
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        hintText: 'Email',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.isNotEmpty ? null : "Please enter a password";
      },
      onSaved: (_input) {
        _password = _input;
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
        hintText: 'Password',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return _auth.status != AuthStatus.Authenticating
        ? SizedBox(
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: MaterialButton(
              color: Colors.blue,
              child: const Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              onPressed: () {
                if (_formKey!.currentState!.validate()) {
                  _auth.registerUserWithEmailAndPassword(_email!, _password!,
                      (String _uid) async {
                    await DBService.instance
                        .createUserInDB(_uid, _name!, _email!);
                  });
                }
              },
            ),
          )
        : const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  Widget _backToLoginPageButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.navigateToPage('login');
      },
      child: SizedBox(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: const Icon(
          Icons.arrow_back,
          size: 40,
        ),
      ),
    );
  }
}
