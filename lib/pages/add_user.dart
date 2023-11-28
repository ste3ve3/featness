// ignore_for_file: file_names, use_build_context_synchronously, use_super_parameters
import 'package:featnessapp/containers/addUser/user_app_bar.dart';
import 'package:featnessapp/pages/home.dart';
import 'package:featnessapp/services/base_client.dart';
import 'package:featnessapp/services/upload_to_cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddUser extends StatefulWidget {
  final dynamic currentUser;
   const AddUser({
    Key? key,
    this.currentUser,
  }) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final BaseClient baseClient = BaseClient();

  late TextEditingController titleController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  String? selectedImage;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.currentUser?.title ?? '');
    firstNameController = TextEditingController(text: widget.currentUser?.firstName ?? '');
    lastNameController = TextEditingController(text: widget.currentUser?.lastName ?? '');
    emailController = TextEditingController(text: widget.currentUser?.email ?? '');
    setState(() {
      selectedImage = widget.currentUser?.picture ?? '';
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        isUploading = true;
      });
      final url = await uploadToCloudinary(pickedImage.path);
      setState(() {
        selectedImage = url;
        isUploading = false;
      });
    }
  }

  void postDataToServer() async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final title = titleController.text;

    final user = {
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'picture': selectedImage,
    };

    if(selectedImage == null) {
      const SnackBar(
        content: Center(child: Text("Image is required!")),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 10),
        showCloseIcon: true,
        backgroundColor: Colors.black,
      );

      return;
    }

    try {
      if(widget.currentUser == null) {
        final ApiResponse<dynamic> response = await baseClient.post('/user/create', user);
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
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
        }
      }
      else {
        final ApiResponse<dynamic> response = await baseClient.put('/user/${widget.currentUser.id}', user);
        if (response.status == Status.COMPLETED) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('User updated successfully!')),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 10),
              showCloseIcon: true,
              backgroundColor: Colors.black,
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
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
        }
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
    }
  }
  @override
  Widget build(BuildContext context) {
    dynamic currentUser = widget.currentUser;

    return Scaffold(
      appBar: userAppBar(context, currentUser),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: selectedImage == null
                              ? 
                              Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.blue, // Background color of the add picture icon
                                        shape: BoxShape.circle, // Make it a circle
                                      ),
                                      child: const Icon(Icons.add, color: Colors.white, size: 15,),
                                    ),
                                  ),
                                ],
                              )
                              : 
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: 
                                  isUploading ?
                                  const Center(
                                    child: SizedBox(
                                      width: 22.0,
                                      height: 22.0,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                      ),
                                    ),
                                  )
                                  :
                                  Image.network(
                                    selectedImage!,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )  
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
                              color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.person_pin),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // borderSide: BorderSide.none,
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
                              color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.person_pin),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // borderSide: BorderSide.none,
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
                              color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.email),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // borderSide: BorderSide.none,
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
                              color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.person_2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // borderSide: BorderSide.none,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                        child: Text(
                          currentUser != null ? 'Save Changes' : "Add User",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}