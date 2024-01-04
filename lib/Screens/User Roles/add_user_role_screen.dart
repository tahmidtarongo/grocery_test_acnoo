import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/GlobalComponents/button_global.dart';
import 'package:mobile_pos/constant.dart';
import 'package:mobile_pos/Screens/User%20Roles/Model/user_role_model.dart' as user;
import 'package:nb_utils/nb_utils.dart';
import '../Authentication/phone.dart';
import 'Repo/user_role_repo.dart';

class AddUserRole extends StatefulWidget {
  const AddUserRole({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddUserRoleState createState() => _AddUserRoleState();
}

class _AddUserRoleState extends State<AddUserRole> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool allPermissions = false;
  bool salePermission = false;
  bool partiesPermission = false;
  bool purchasePermission = false;
  bool productPermission = false;
  bool profileEditPermission = false;
  bool addExpensePermission = false;
  bool lossProfitPermission = false;
  bool dueListPermission = false;
  bool stockPermission = false;
  bool reportsPermission = false;
  bool salesListPermission = false;
  bool purchaseListPermission = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Add User Role',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: kGreyTextColor),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        ///_______all_&_sale____________________________________________
                        Row(
                          children: [
                            ///_______all__________________________
                            SizedBox(
                              width: context.width() / 2 - 20,
                              child: CheckboxListTile(
                                value: allPermissions,
                                onChanged: (value) {
                                  if (value == true) {
                                    setState(() {
                                      allPermissions = value!;
                                      salePermission = true;
                                      partiesPermission = true;
                                      purchasePermission = true;
                                      productPermission = true;
                                      profileEditPermission = true;
                                      addExpensePermission = true;
                                      lossProfitPermission = true;
                                      dueListPermission = true;
                                      stockPermission = true;
                                      reportsPermission = true;
                                      salesListPermission = true;
                                      purchaseListPermission = true;
                                    });
                                  } else {
                                    setState(() {
                                      allPermissions = value!;
                                      salePermission = false;
                                      partiesPermission = false;
                                      purchasePermission = false;
                                      productPermission = false;
                                      profileEditPermission = false;
                                      addExpensePermission = false;
                                      lossProfitPermission = false;
                                      dueListPermission = false;
                                      stockPermission = false;
                                      reportsPermission = false;
                                      salesListPermission = false;
                                      purchaseListPermission = false;
                                    });
                                  }
                                },
                                title: const Text('All'),
                              ),
                            ),
                          ],
                        ),

                        ///_______Edit Profile_&_sale____________________________________________
                        Row(
                          children: [
                            ///_______Edit_Profile_________________________
                            Expanded(
                              child: CheckboxListTile(
                                value: profileEditPermission,
                                onChanged: (value) {
                                  setState(() {
                                    profileEditPermission = value!;
                                  });
                                },
                                title: const Text('Profile Edit'),
                              ),
                            ),

                            ///______sales____________________________
                            Expanded(
                              child: CheckboxListTile(
                                value: salePermission,
                                onChanged: (value) {
                                  setState(() {
                                    salePermission = value!;
                                  });
                                },
                                title: const Text('Sales'),
                              ),
                            ),
                          ],
                        ),

                        ///_____parties_&_Purchase_________________________________________
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: partiesPermission,
                                onChanged: (value) {
                                  setState(() {
                                    partiesPermission = value!;
                                  });
                                },
                                title: const Text('Parties'),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                value: purchasePermission,
                                onChanged: (value) {
                                  setState(() {
                                    purchasePermission = value!;
                                  });
                                },
                                title: const Text('Purchase'),
                              ),
                            ),
                          ],
                        ),

                        ///_____Product_&_DueList_________________________________________
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: productPermission,
                                onChanged: (value) {
                                  setState(() {
                                    productPermission = value!;
                                  });
                                },
                                title: const Text('Products'),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                value: dueListPermission,
                                onChanged: (value) {
                                  setState(() {
                                    dueListPermission = value!;
                                  });
                                },
                                title: const Text('Due List'),
                              ),
                            ),
                          ],
                        ),

                        ///_____Stock_&_Reports_________________________________________
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: stockPermission,
                                onChanged: (value) {
                                  setState(() {
                                    stockPermission = value!;
                                  });
                                },
                                title: const Text('Stock'),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                value: reportsPermission,
                                onChanged: (value) {
                                  setState(() {
                                    reportsPermission = value!;
                                  });
                                },
                                title: const Text('Reports'),
                              ),
                            ),
                          ],
                        ),

                        ///_____SalesList_&_Purchase List_________________________________________
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: salesListPermission,
                                onChanged: (value) {
                                  setState(() {
                                    salesListPermission = value!;
                                  });
                                },
                                title: const Text('Sales List'),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                value: purchaseListPermission,
                                onChanged: (value) {
                                  setState(() {
                                    purchaseListPermission = value!;
                                  });
                                },
                                title: const Text('Purchase List'),
                              ),
                            ),
                          ],
                        ),

                        ///_____LossProfit_&_Expense_________________________________________
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: lossProfitPermission,
                                onChanged: (value) {
                                  setState(() {
                                    lossProfitPermission = value!;
                                  });
                                },
                                title: const Text('Loss Profit'),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                value: addExpensePermission,
                                onChanged: (value) {
                                  setState(() {
                                    addExpensePermission = value!;
                                  });
                                },
                                title: const Text('Expense'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///___________Text_fields_____________________________________________
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        ///___________________________________________________________________
                        AppTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone can\'n be empty';
                            }
                            return null;
                          },
                          showCursor: true,
                          controller: phoneController,
                          // cursorColor: kTitleColor,
                          decoration: kInputDecoration.copyWith(
                            labelText: 'Phone',
                            // labelStyle: kTextStyle.copyWith(color: kTitleColor),
                            hintText: 'Enter your phone number',
                            // hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                            contentPadding: const EdgeInsets.all(10.0),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                            ),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                            ),
                          ),
                          textFieldType: TextFieldType.EMAIL,
                        ),
                        const SizedBox(height: 20.0),

                        ///__________email_________________________________________________________
                        // AppTextField(
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Email can\'n be empty';
                        //     } else if (!value.contains('@')) {
                        //       return 'Please enter a valid email';
                        //     }
                        //     return null;
                        //   },
                        //   showCursor: true,
                        //   controller: emailController,
                        //   // cursorColor: kTitleColor,
                        //   decoration: kInputDecoration.copyWith(
                        //     labelText: 'Email',
                        //     // labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        //     hintText: 'Enter your email address',
                        //     // hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                        //     contentPadding: const EdgeInsets.all(10.0),
                        //     enabledBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(4.0),
                        //       ),
                        //       borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                        //     ),
                        //     errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                        //     ),
                        //   ),
                        //   textFieldType: TextFieldType.EMAIL,
                        // ),
                        // const SizedBox(height: 20.0),

                        ///______password___________________________________________________________
                        // AppTextField(
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Password can\'t be empty';
                        //     } else if (value.length < 4) {
                        //       return 'Please enter a bigger password';
                        //     }
                        //     return null;
                        //   },
                        //   controller: passwordController,
                        //   showCursor: true,
                        //   // cursorColor: kTitleColor,
                        //   decoration: kInputDecoration.copyWith(
                        //     labelText: 'Password',
                        //     floatingLabelAlignment: FloatingLabelAlignment.start,
                        //     // labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        //     hintText: 'Enter your password',
                        //     // hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                        //     contentPadding: const EdgeInsets.all(10.0),
                        //     enabledBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(4.0),
                        //       ),
                        //       borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                        //     ),
                        //     errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                        //     ),
                        //   ),
                        //   textFieldType: TextFieldType.PASSWORD,
                        // ),

                        ///________retype_email____________________________________________________
                        // const SizedBox(height: 20.0),
                        // AppTextField(
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Password can\'t be empty';
                        //     } else if (value != passwordController.text) {
                        //       return 'Password and confirm password does not match';
                        //     } else if (value.length < 4) {
                        //       return 'Please enter a bigger password';
                        //     }
                        //     return null;
                        //   },
                        //   controller: confirmPasswordController,
                        //   showCursor: true,
                        //   // cursorColor: kTitleColor,
                        //   decoration: kInputDecoration.copyWith(
                        //     labelText: 'Password',
                        //     floatingLabelAlignment: FloatingLabelAlignment.start,
                        //     // labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        //     hintText: 'Enter your password',
                        //     // hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                        //     contentPadding: const EdgeInsets.all(10.0),
                        //     errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        //     enabledBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(4.0),
                        //       ),
                        //       borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                        //     ),
                        //     focusedBorder: const OutlineInputBorder(
                        //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        //       borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                        //     ),
                        //   ),
                        //   textFieldType: TextFieldType.PASSWORD,
                        // ),

                        ///__________Title_________________________________________________________

                        AppTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User title can\'n be empty';
                            }
                            return null;
                          },
                          showCursor: true,
                          controller: titleController,
                          decoration: kInputDecoration.copyWith(
                            labelText: 'User Title',
                            hintText: 'Enter User Title',
                            contentPadding: const EdgeInsets.all(10.0),
                            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(color: kBorderColorTextField, width: 2),
                            ),
                          ),
                          textFieldType: TextFieldType.EMAIL,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonGlobalWithoutIcon(
              buttontext: 'Create',
              buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
              onPressed: (() async {
                if (salePermission ||
                    partiesPermission ||
                    purchasePermission ||
                    productPermission ||
                    profileEditPermission ||
                    addExpensePermission ||
                    lossProfitPermission ||
                    dueListPermission ||
                    stockPermission ||
                    reportsPermission ||
                    salesListPermission ||
                    purchaseListPermission) {
                  if (validateAndSave()) {
                    user.Permission permission = user.Permission(
                      salePermission: salePermission,
                      partiesPermission: partiesPermission,
                      purchasePermission: purchasePermission,
                      productPermission: productPermission,
                      profileEditPermission: profileEditPermission,
                      addExpensePermission: addExpensePermission,
                      lossProfitPermission: lossProfitPermission,
                      dueListPermission: dueListPermission,
                      stockPermission: stockPermission,
                      reportsPermission: reportsPermission,
                      salesListPermission: salesListPermission,
                      purchaseListPermission: purchaseListPermission,
                    );

                    UserRoleRepo userRepo = UserRoleRepo();

                    await userRepo.addUser(
                      ref: ref,
                      context: context,
                      name: titleController.text,
                      phone: phoneController.text,
                      permission: permission,
                    );
                  }
                } else {
                  EasyLoading.showError('You Have To Give Permission');
                }
              }),
              buttonTextColor: Colors.white),
        ),
      );
    });
  }
}
