import 'package:flutter/material.dart';

SingleChildScrollView addUserForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(right:20, left: 20, bottom: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "New User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Colors.black, 
                thickness: 1.0, 
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "First Name",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter first name',
                        hintStyle: const TextStyle(
                          color: Color(0xffDDDADA),
                          fontSize: 14
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.person_pin),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                    ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Last Name",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter last name',
                        hintStyle: const TextStyle(
                          color: Color(0xffDDDADA),
                          fontSize: 14
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.person_pin),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                    ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        hintStyle: const TextStyle(
                          color: Color(0xffDDDADA),
                          fontSize: 14
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.email),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                    ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.only(top:10, right: 25, bottom: 10, left: 25),
                    decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, 
                      width: 2.0,         
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text(
                    "Cancel", 
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.only(top:12, right: 25, bottom: 12, left: 25),
                    decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Text(
                    "Create", 
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }