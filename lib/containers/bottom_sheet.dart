// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:featnessapp/services/base_client.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class BottomSheetContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  const BottomSheetContainer({
    super.key,
    required this.child,
    this.padding,
    this.decoration,
  });

  @override
  State<BottomSheetContainer> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetContainer> {
  final BaseClient baseClient = BaseClient();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }


  Future<String?> imageToBase64() async {
    if (selectedImage == null) return null;

    List<int> imageBytes = await selectedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }

  void postDataToServer() async {
    String? base64Image = await imageToBase64();
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final title = titleController.text;
    final picture = base64Image;

    final user = {
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'picture': picture,
    };

    try {
      final ApiResponse<dynamic> response =
          await baseClient.post('/user/create', user);
      if (response.status == Status.COMPLETED) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('User added successfully!')),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 10),
            showCloseIcon: true,
            backgroundColor: Colors.black,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text("${response.error}")),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 10),
            showCloseIcon: true,
            backgroundColor: Colors.black,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text("$e")),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 10),
          showCloseIcon: true,
          backgroundColor: Colors.black,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: widget.decoration,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
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
                                style:
                                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter first name',
                                  hintStyle: const TextStyle(
                                      color: Color(0xffDDDADA), fontSize: 14),
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
                                style:
                                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter last name',
                                  hintStyle: const TextStyle(
                                      color: Color(0xffDDDADA), fontSize: 14),
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
                                style:
                                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter email',
                                  hintStyle: const TextStyle(
                                      color: Color(0xffDDDADA), fontSize: 14),
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
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Title",
                                style:
                                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  hintText: 'Enter title',
                                  hintStyle: const TextStyle(
                                      color: Color(0xffDDDADA), fontSize: 14),
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
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Picture",
                                style:
                                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: selectedImage == null
                                      ? const Icon(Icons.image,
                                          size: 50, color: Colors.grey)
                                      : Image.file(
                                          selectedImage!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 25, bottom: 10, left: 25),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10))),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                postDataToServer();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 12, right: 25, bottom: 12, left: 25),
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Text(
                                  "Create",
                                  style: TextStyle(color: Colors.white),
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
            });
        },
        child: widget.child,
      ),
    );
  }
}
