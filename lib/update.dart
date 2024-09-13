import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateWidget extends StatefulWidget {
  final Map<String,dynamic>item;
  const UpdateWidget({super.key,required this.item});

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}
class _UpdateWidgetState extends State<UpdateWidget> {
  final _formKey = GlobalKey<FormState>();
   TextEditingController _firstNameController = TextEditingController();
   TextEditingController _lastNameController = TextEditingController();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _phoneNumberController = TextEditingController();

@override
  void initState() {
    super.initState();
    _firstNameController=TextEditingController(text: widget.item['FIRST_NAME']);
    _lastNameController=TextEditingController(text: widget.item['LAST_NAME']);
    _emailController=TextEditingController(text: widget.item['EMAIL']);
    _phoneNumberController=TextEditingController(text: widget.item['PHONE']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'UPDATE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key:_formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      helperText: 'First Name',
                      hintText: 'First Name',
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'please enter your First name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      helperText: 'Last Name',
                      hintText: 'Last Name',
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      helperText: 'Email',
                      hintText: 'Email',
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      helperText: 'Phone',
                      hintText: 'Phone',
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'please enter your number ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                    setState(() {
                        Update();
                        Navigator.popAndPushNamed(context, '/');
                    });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('data updated succefully'))
                      );
                    }
                    // Handle update action here
                  },
                  child: Text(
                    'UPDATE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Future<void>Update() async {
    var url = Uri.parse('http://192.168.58.60/CRUD/update.php');
    await http.post(
      url,
      body: {
        'id': widget.item['ID'].toString(), 
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'email': _emailController.text,
        'phonenumber': _phoneNumberController.text,
      },
    );
  }

}
