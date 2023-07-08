import 'package:contacts_app/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Daftar Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Nama',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Nomor Telepon',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Alamat Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String phoneNumber = phoneNumberController.text.trim();
                      String email = emailController.text.trim();
                      if (name.isNotEmpty && phoneNumber.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          phoneNumberController.text = '';
                          emailController.text = '';
                          contacts.add(Contact(
                              name: name,
                              phoneNumber: phoneNumber,
                              email: email));
                        });
                      }
                      //
                    },
                    child: const Text('Simpan')),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String phoneNumber = phoneNumberController.text.trim();
                      String email = nameController.text.trim();
                      if (name.isNotEmpty &&
                          phoneNumber.isNotEmpty &&
                          email.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          phoneNumberController.text = '';
                          emailController.text = '';
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].phoneNumber = phoneNumber;
                          contacts[selectedIndex].email = email;
                          selectedIndex = -1;
                        });
                      }
                      //
                    },
                    child: const Text('Edit')),
              ],
            ),
            const SizedBox(height: 150),
            contacts.isEmpty
                ? const Text(
                    'Tidak Ada Kontak',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].phoneNumber),
            Text(
              contacts[index].email,
            )
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    phoneNumberController.text = contacts[index].phoneNumber;
                    emailController.text = contacts[index].email;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
