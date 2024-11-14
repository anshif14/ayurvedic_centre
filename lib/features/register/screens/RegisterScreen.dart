import 'package:ayurvedic_centre/core/providers/patient_provider.dart';
import 'package:ayurvedic_centre/core/providers/treatment_provider.dart';
import 'package:ayurvedic_centre/models/patientModel.dart';
import 'package:ayurvedic_centre/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/common/color_palette.dart';
import '../../../core/providers/branch_provider.dart';
import '../../../main.dart';
import '../../../models/branchModel.dart' as branch;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field
  final nameController = TextEditingController();
  final whatsappController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();

  String? selectedLocation;
  String? selectedBranch;
  String? paymentOption;
  DateTime? treatmentDate;
  int maleCount = 0;
  int femaleCount = 0;

  // Decoration for text fields
  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: Color(0x1a000000)),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: Color(0x1a000000)),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: Color(0x1a000000)),
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: Color(0xFFF7F7F7), // Adjust according to `ColorPalette.textFieldBackground`
      filled: true,
      hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w300),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // String selectedLocation = "Kochi";
  // String selectedBranch = '';
  List<int> selectedTreatments = [];
  // Other form fields and variables...

  List<Branch> branchesList =[];

  @override
  void initState() {
    super.initState();

    // Fetch branches and treatments on initial load
    // ApiService().fetchBranches().then((branches) {
    //   setState(() {
    //     // Populate branches
    //
    //     print(branches);
    //
    //
    //
    //
    //
    //       selectedBranch  = branches.branches.first.id.toString();
    //
    //
    //   });
    //   print(selectedBranch);
    //   print("selectedBranch");
    //
    // });
    //
    // ApiService().fetchTreatments().then((treatments) {
    //   setState(() {
    //     // Populate treatments
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final branchProvider = Provider.of<BranchProvider>(context);

    final treatmentProvider = Provider.of<TreatmentProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      branchProvider.fetchBranches();
      treatmentProvider.fetchTreatments();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        surfaceTintColor: Colors.white,
        title: Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: customInputDecoration("Enter your full name"),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: whatsappController,
                decoration: customInputDecoration("Enter your WhatsApp number"),
                validator: (value) => value!.isEmpty ? 'WhatsApp number is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: addressController,
                decoration: customInputDecoration("Enter your full address"),
                validator: (value) => value!.isEmpty ? 'Address is required' : null,
              ),
              SizedBox(height: 16),
              // DropdownButtonFormField<String>(
              //   decoration: customInputDecoration("Choose your location"),
              //   items: ['Location 1', 'Location 2', 'Location 3']
              //       .map((location) => DropdownMenuItem(
              //     value: location,
              //     child: Text(location),
              //   ))
              //       .toList(),
              //   onChanged: (value) => setState(() => selectedLocation = value),
              //   validator: (value) => value == null ? 'Location is required' : null,
              // ),

              Consumer<BranchProvider>(
                builder: (context, branchProvider, child) {
                  return DropdownButtonFormField<String>(
                    decoration: customInputDecoration("Select Your Location"),
                    items: branchProvider.branches.map((branch) {
                      return DropdownMenuItem<String>(
                        value: branch.id.toString(),
                        child: Text(branch.name),
                      );
                    }).toList(),
                    value: selectedLocation,

                    onChanged: (value) => setState(() => selectedLocation = value),
                    validator: (value) => value == null ? 'Location is required' : null,
                  );
                },
              ),
              SizedBox(height: 16),


            Consumer<BranchProvider>(
              builder: (context, branchProvider, child) {
                return DropdownButtonFormField<String>(
                  decoration: customInputDecoration("Select the branch"),
                  items: branchProvider.branches.map((branch) {
                    return DropdownMenuItem<String>(
                      value: branch.id.toString(),
                      child: Text(branch.name),
                    );
                  }).toList(),
                  value: selectedBranch,
                  onChanged: (value) {
                    setState(() {
                      selectedBranch = value;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Branch is required' : null,
                );
              },
            ),


              SizedBox(height: 16),

              // Treatments Section
              Text("Treatments"),
              SizedBox(height: 8),
              // Container(
              //   padding: EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Color(0xFFF7F7F7),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text("Male"),
              //           SizedBox(width: 8),
              //           CounterButton(
              //             count: maleCount,
              //             onIncrement: () => setState(() => maleCount++),
              //             onDecrement: () => setState(() => maleCount = maleCount > 0 ? maleCount - 1 : 0),
              //           ),
              //           SizedBox(width: 16),
              //           Text("Female"),
              //           SizedBox(width: 8),
              //           CounterButton(
              //             count: femaleCount,
              //             onIncrement: () => setState(() => femaleCount++),
              //             onDecrement: () => setState(() => femaleCount = femaleCount > 0 ? femaleCount - 1 : 0),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Treatments",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    // padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorPalette.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: 1,
                      //     blurRadius: 5,
                      //   ),
                      // ],
                    ),
                    child: Column(
                      children: [

                        ListTile(
                          leading: Text('1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          title: Text("Couple Combo package i..." ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                          trailing:  Icon(CupertinoIcons.clear_circled_solid,color: Color.fromRGBO(242, 30, 30, 0.5),size: 30,),
                        ),
                        // Text(
                        //   "1. ,
                        //   style: TextStyle(fontSize: 16),
                        // ),
                        // Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Wrap(
                             crossAxisAlignment : WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Male",style: TextStyle(color: ColorPalette.primaryColor),),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[200],
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(child: Text("2")),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),

                            Wrap(
                              crossAxisAlignment : WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Female",style: TextStyle(color: ColorPalette.primaryColor),),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[200],
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(child: Text("2")),
                                ),
                              ],
                            ),

                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.green),
                              onPressed: () {
                                // Edit action
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),


                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: width*0.9,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return addTreatmentDialogue();
                          },
                        );
                        // Add Treatments action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(56, 154, 72, 0.3)
                      ,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "+ Add Treatments",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: totalAmountController,
                decoration: customInputDecoration("Total Amount"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: discountAmountController,
                decoration: customInputDecoration("Discount Amount"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              // Payment Option
              Text("Payment Option"),
              Row(
                children: [
                  Radio(
                    value: 'Cash',
                    groupValue: paymentOption,
                    onChanged: (value) => setState(() => paymentOption = value),
                  ),
                  Text("Cash"),
                  Radio(
                    value: 'Card',
                    groupValue: paymentOption,
                    onChanged: (value) => setState(() => paymentOption = value),
                  ),
                  Text("Card"),
                  Radio(
                    value: 'UPI',
                    groupValue: paymentOption,
                    onChanged: (value) => setState(() => paymentOption = value),
                  ),
                  Text("UPI"),
                ],
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: advanceAmountController,
                decoration: customInputDecoration("Advance Amount"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: balanceAmountController,
                decoration: customInputDecoration("Balance Amount"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              // Treatment Date
              GestureDetector(
                onTap: () async {
                  treatmentDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  setState(() {});
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: customInputDecoration("Treatment Date"),
                    controller: TextEditingController(
                      text: treatmentDate != null ? treatmentDate.toString().split(' ')[0] : '',
                    ),
                    validator: (value) => value!.isEmpty ? 'Date is required' : null,
                  ),
                ),
              ),
              SizedBox(height:100 ),


            ],
          ),
        ),
      ),
      bottomSheet:

      Consumer<PatientProvider>(
        builder: (context, provider, child) {
          return SizedBox(
            height:80 ,
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: width*0.9,
                  child: ElevatedButton(
                    onPressed: () {

                      ApiService().registerPatient(
                        name: "John Doe",
                        executive: "Dr. Smith",
                        payment: "Cash",
                        phone: "1234567890",
                        address: "Kochi, Kerala",
                        totalAmount: 1000.0,
                        discountAmount: 100.0,
                        advanceAmount: 200.0,
                        balanceAmount: 700.0,
                        dateNdTime: "01/02/2024-10:24 AM",
                        maleTreatments: "1,2",
                        femaleTreatments: "3,4",
                        branch: selectedBranch.toString(),
                        treatments: selectedTreatments??[],
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
  addTreatmentDialogue(){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Treatment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Choose preferred treatment",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Add Patients",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Male"),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            color: Colors.green,
                            onPressed: () {
                              // Decrease male count
                            },
                          ),
                          Expanded(
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text("0"), // Display male count here
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            color: Colors.green,
                            onPressed: () {
                              // Increase male count
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Text("Female"),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            color: Colors.green,
                            onPressed: () {
                              // Decrease female count
                            },
                          ),
                          Expanded(
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text("0"), // Display female count here
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            color: Colors.green,
                            onPressed: () {
                              // Increase female count
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterButton extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  CounterButton({required this.count, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: onDecrement,
        ),
        Text(count.toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onIncrement,
        ),
      ],
    );
  }
}
