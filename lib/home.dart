import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:php_flutter/update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homewidget extends StatefulWidget {
  const Homewidget({super.key});


  @override
  State<Homewidget> createState() => _HomewidgetState();
}

class _HomewidgetState extends State<Homewidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Logout(context);
            },
          ),
        ],
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            "CRUD",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
          refreshData();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Data not found"));
            } else {
              var data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color.fromARGB(255, 185, 181, 181),
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(data[index]['FIRST_NAME']),
                        subtitle: Text(data[index]['EMAIL']),
                        leading: GestureDetector(
                          child: Icon(Icons.update),
                          onTap: ()async {
                            bool?result= await Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>
                            UpdateWidget(item: data[index])));
                            if(result==true)
                            {
                              refreshData();
                            }
                            // Update action here
                          },
                        ),
                        trailing: GestureDetector(

                          child: Icon(Icons.delete),
                          onTap: () {
                            showDialog(
                              context: context,
                               builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text('Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();

                                      },
                                       child: Text('Cancel')),
                                       TextButton(onPressed: (){
                                        deleteData(data[index]['ID']);
                                        Navigator.of(context).pop();
                                       }, child: Text('Delete'))
                                  ],
                                );
                               });
                            // Delete action here
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<dynamic>> getData() async {
    var url = Uri.parse('http://192.168.58.60/CRUD/get.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
      super.initState();
      getData();
  }
   
   void refreshData(){
    setState(() {
          getData();

      
    });
    
   }
   Future<void> deleteData(String id) async {
    var url = Uri.parse('http://192.168.58.60/CRUD/delete.php');
    var response = await http.post(
      url,
      body: {
        'id': id,
      },
    );

    if (response.statusCode == 200) {
      refreshData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item')),
      );
    }
  }
Future<void>Logout(BuildContext context) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  await prefs.clear();
  Navigator.pushNamed(context, '/');
}
 
}
