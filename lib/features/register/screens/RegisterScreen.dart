import 'package:ayurvedic_centre/core/common/PdfGenerator.dart';
import 'package:ayurvedic_centre/core/common/TopSnackBarWidget.dart';
import 'package:ayurvedic_centre/core/providers/patientListProvider.dart';
import 'package:ayurvedic_centre/core/providers/patient_provider.dart';
import 'package:ayurvedic_centre/core/providers/treatment_provider.dart';
import 'package:ayurvedic_centre/models/generate_pdf_model.dart';
import 'package:ayurvedic_centre/models/patientModel.dart';
import 'package:ayurvedic_centre/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/common/color_palette.dart';
import '../../../core/common/genetatePdf.dart';
import '../../../core/providers/branch_provider.dart';
import '../../../main.dart';
import '../../../models/branchModel.dart' as branch;
import '../../../models/trearment.dart' as treatmentModel;

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
  num maleCount = 0;
  num femaleCount = 0;

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
      fillColor: Color(
          0xFFF7F7F7), // Adjust according to `ColorPalette.textFieldBackground`
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

  List<branch.Branch> branchesList = [];

  getBranches()async{
    // final branchProvider = Provider.of<BranchProvider>(context);

    branch.BranchModel branchModel ;

    branchModel = await ApiService().fetchBranches();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   branchProvider.fetchBranches();
    //   // treatmentProvider.fetchTreatments();
    // });
    branchesList = branchModel.branches;
    setState(() {

    });
    print(branchesList);
  }
  bool _isBranchesFetched = false;

  @override
  void initState() {
    super.initState();
getBranches();
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
    final patientListProvider = Provider.of<PatientListProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);

    if(!_isBranchesFetched){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        branchProvider.fetchBranches();
        treatmentProvider.fetchTreatments();
      });
      _isBranchesFetched = true;
    }

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
                validator: (value) =>
                    value!.isEmpty ? 'Name is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 10,
                controller: whatsappController,
                decoration: customInputDecoration("Enter your WhatsApp number"),
                validator: (value) =>
                    value!.isEmpty ? 'WhatsApp number is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                maxLines: null,
                textInputAction: TextInputAction.newline,
                minLines: 2,
                // maxLength:5,

                controller: addressController,
                decoration: customInputDecoration("Enter your full address"),
                validator: (value) =>
                    value!.isEmpty ? 'Address is required' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: customInputDecoration("Choose your location"),
                items: ['Malappuram', 'Calicut', 'Palakkad']
                    .map((location) => DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => selectedLocation = value),
                validator: (value) =>
                    value == null ? 'Location is required' : null,
              ),

              // Consumer<BranchProvider>(
              //   builder: (context, branchProvider, child) {
              //     return DropdownButtonFormField<String>(
              //       decoration: customInputDecoration("Select Your Location"),
              //       items: branchProvider.branches.map((branch) {
              //         return DropdownMenuItem<String>(
              //           value: branch.id.toString(),
              //           child: Text(branch.name),
              //         );
              //       }).toList(),
              //       value: selectedLocation,
              //       onChanged: (value) =>
              //           setState(() => selectedLocation = value),
              //       validator: (value) =>
              //           value == null ? 'Location is required' : null,
              //     );
              //   },
              // ),
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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: patientListProvider.patientList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                                  leading: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  title: Text(
                                      patientListProvider.patientList[index]
                                          ['treatment_name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      patientListProvider.removePatient(index);
                                    },
                                    child: Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      color: Color.fromRGBO(242, 30, 30, 0.5),
                                      size: 30,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   "1. ,
                                //   style: TextStyle(fontSize: 16),
                                // ),
                                // Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Male",
                                            style: TextStyle(
                                                color: ColorPalette.primaryColor),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            // color: Colors.grey[200],
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                              child: Text(patientListProvider
                                                  .patientList[index]['maleCount']
                                                  .toString())),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Female",
                                            style: TextStyle(
                                                color: ColorPalette.primaryColor),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            // color: Colors.grey[200],
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                              child: Text(patientListProvider
                                                  .patientList[index]
                                                      ['femaleCount']
                                                  .toString())),
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
                        );
                      }),
                  const SizedBox(height: 16),
                  Container(
                    width: width * 0.9,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        treatmentModel.TreatmentModel treatment =
                            await treatmentProvider.fetchTreatments();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
// // return StatefulBuilder(builder: (context, setState) {
//  return addTreatmentDialogue(treatment:  treatment );
// // },);

                            return addPatientsAlert(treatment: treatment);
                          },
                        );
                        // Add Treatments action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(56, 154, 72, 0.3),
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
                      text: treatmentDate != null
                          ? treatmentDate.toString().split(' ')[0]
                          : '',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Date is required' : null,
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomSheet:
          Consumer<PatientProvider>(builder: (context, provider, child) {
        return SizedBox(
          height: 80,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      topSnackBarWidget()
                          .topSnackBarError(context, "Please enter name");
                      return;
                    }
                    if (whatsappController.text.isEmpty) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please enter WhatsApp number");
                      return;
                    }
                    if (addressController.text.isEmpty) {
                      topSnackBarWidget()
                          .topSnackBarError(context, "Please enter address");
                      return;
                    }
                    if (selectedLocation == null) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please select your location");
                      return;
                    }
                    if (selectedBranch == null) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please select your branch");
                      return;
                    }
                    if (patientListProvider.patientList.isEmpty) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please add at least one treatment");
                      return;
                    }
                    if (totalAmountController.text.isEmpty) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please enter total amount");
                      return;
                    }
                    if (discountAmountController.text.isEmpty) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please enter discount amount");
                      return;
                    }
                    if (paymentOption == null) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please select a payment option");
                      return;
                    }
                    if (advanceAmountController.text.isEmpty) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please enter advance amount");
                      return;
                    }
                    if (balanceAmountController.text.isEmpty) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please enter balance amount");
                      return;
                    }
                    if (treatmentDate == null) {
                      topSnackBarWidget().topSnackBarError(
                          context, "Please select a treatment date");
                      return;
                    }



                    for (var docs in patientListProvider.patientList) {
                      print(docs["maleCount"]);
                      print(docs["femaleCount"]);
                      maleCount = maleCount + num.parse(docs["maleCount"].toString());
                      femaleCount = femaleCount + num.parse(docs["femaleCount"].toString());
                    }

                    ///=================================
                    GeneratePdfModel pdfModel = GeneratePdfModel(
                        name: nameController.text,
                        executive: 'executive',
                        payment: paymentOption.toString(),
                        phone: whatsappController.text,
                        address: addressController.text,
                        totalAmount:
                            double.tryParse(totalAmountController.text) ?? 0,
                        discountAmount:
                            double.tryParse(discountAmountController.text) ?? 0,
                        advanceAmount:
                            double.tryParse(advanceAmountController.text) ?? 0,
                        balanceAmount:
                            double.tryParse(balanceAmountController.text) ?? 0,
                        dateNdTime: DateFormat('dd/MM/yyyy').format(treatmentDate!),
                        maleTreatments: maleCount.toString(),
                        femaleTreatments: femaleCount.toString(),
                        branch: selectedBranch.toString(),
                        treatments: selectedTreatments);

                    ;

                    generatePdfFunction(pdfModel: pdfModel);



                    patientProvider.registerPatient(
                      id: '',
                        name: nameController.text,
                        executive: 'executive',
                        payment: paymentOption.toString(),
                        phone: whatsappController.text,
                        address: addressController.text,
                        totalAmount:
                        (double.tryParse(totalAmountController.text) ?? 0),
                        discountAmount:
                        (double.tryParse(discountAmountController.text) ?? 0),
                        advanceAmount:
                        (double.tryParse(advanceAmountController.text) ?? 0),
                        balanceAmount:
                        (double.tryParse(balanceAmountController.text) ?? 0),
                        date_nd_time: DateFormat('dd/MM/yyyy').format(treatmentDate!),
                        male: maleCount.toString(),
                        female: femaleCount.toString(),
                        branch: selectedBranch.toString(),
                        treatments: selectedTreatments.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.primaryColor, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child:patientProvider.isSubmitLoading?
                    CircularProgressIndicator(
                      color: Colors.white,
                    ):
                    Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class addPatientsAlert extends StatefulWidget {
  const addPatientsAlert({super.key, required this.treatment});
  final treatmentModel.TreatmentModel treatment;

  @override
  State<addPatientsAlert> createState() => _addPatientsAlertState();
}

class _addPatientsAlertState extends State<addPatientsAlert> {
  int? selectedTreatment;
  String? selectedTreatmentName;
  int maleCount = 1;
  int femaleCount = 1;

  @override
  Widget build(BuildContext context) {
    print(maleCount);
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
            // DropdownButtonFormField(
            //   isExpanded: true,
            //   decoration: customInputDecoration("Choose your treatment"),
            //   items: widget.treatment.treatments
            //       .map((location) => DropdownMenuItem(
            //
            //     value: location.id,
            //     child: Text(location.name,overflow: TextOverflow.ellipsis,),
            //   ))
            //       .toList(),
            //   onChanged: (value) {
            //
            //
            //     setState(() => selectedTreatment = value);},
            //   validator: (value) => value == null ? 'Location is required' : null,
            // ),
            DropdownButtonFormField(
              isExpanded: true,
              decoration: customInputDecoration("Choose your treatment"),
              items: widget.treatment.treatments
                  .map((location) => DropdownMenuItem(
                        value:
                            location, // Set the entire location object as the value
                        child: Text(
                          location.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                // Cast the value to the correct type
                final selectedLocation = value as treatmentModel.Treatment;
                print(selectedLocation.id);
                print(selectedLocation.name);
                setState(() {
                  selectedTreatment = selectedLocation.id;
                  selectedTreatmentName = selectedLocation.name;
                });
              },
              validator: (value) =>
                  value == null ? 'Location is required' : null,
            ),

            const SizedBox(height: 16),
            Text(
              "Add Patients",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Male"), // Display male count here
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (maleCount > 1) {
                          maleCount = maleCount - 1;
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff006837), shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          '-',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          Text(maleCount.toString()), // Display male count here
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        maleCount = maleCount + 1;

                        setState(() {});
                        ;
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff006837), shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          '+',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Female"), // Display male count here
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (femaleCount > 1) {
                          femaleCount = femaleCount - 1;
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff006837), shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          '-',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                          femaleCount.toString()), // Display male count here
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        femaleCount = femaleCount + 1;

                        setState(() {});
                        ;
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff006837), shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          '+',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedTreatment == null) {
                            return;
                          }
                          Provider.of<PatientListProvider>(context,
                                  listen: false)
                              .addPatient(
                                  femaleCount: femaleCount,
                                  maleCount: maleCount,
                                  treatmentId: selectedTreatment.toString(),
                                  treatmentName:
                                      selectedTreatmentName.toString());
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedTreatment == null
                              ? Colors.grey
                              : ColorPalette.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
      fillColor: Color(
          0xFFF7F7F7), // Adjust according to `ColorPalette.textFieldBackground`
      filled: true,
      hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w300),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
