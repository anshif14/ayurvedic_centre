import 'package:ayurvedic_centre/core/common/color_palette.dart';
import 'package:ayurvedic_centre/core/common/imageConstants.dart';
import 'package:ayurvedic_centre/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/patient_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> bookings = [
    {
      "name": "Vikram Singh",
      "package": "Couple Combo Package (Rejuvenation)",
      "date": "31/01/2024",
      "staff": "Jithesh"
    },
    {
      "name": "Vikram Singh",
      "package": "Couple Combo Package (Rejuvenation)",
      "date": "31/01/2024",
      "staff": "Jithesh"
    },
    {
      "name": "Vikram Singh",
      "package": "Couple Combo Package (Rejuvenation)",
      "date": "31/01/2024",
      "staff": "Jithesh"
    },
    {
      "name": "Vikram Singh",
      "package": "Couple Combo Package (Rejuvenation)",
      "date": "31/01/2024",
      "staff": "Jithesh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      patientProvider.fetchPatients();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        // title: Text("Bookings"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Add back navigation functionality
        //   },
        // ),
        actions: [
         SvgPicture.asset(ImageConstants.bellIconSvg)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  // flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search for treatments",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.8, color: Color(0x1a000000)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.8, color: Color(0x1a000000)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.8, color: Color(0x1a000000)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // fillColor: ColorPalette.textFieldBackground,
                          // filled: true,
                          hintStyle:
                          GoogleFonts.inter(fontWeight: FontWeight.w300),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add registration functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            // Sort Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sort by :"),
                SizedBox(width: 10),
                Container(
                  width: width*0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,0,8,0,),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      value: "Date",
                      items: [
                        DropdownMenuItem(
                          value: "Date",
                          child: Text("Date"),
                        ),
                        DropdownMenuItem(
                          value: "Name",
                          child: Text("Name"),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle sort selection
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // ListView Builder for Bookings
            Consumer<PatientProvider>(
              builder: (context, provider, _  ) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return Container(
                decoration: BoxDecoration(
                  color: ColorPalette.cardBackground,
                  borderRadius: BorderRadius.circular(12)
                ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                "${index + 1}. ${booking['name']}",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      booking['package'] ?? "",
                                      style: TextStyle(color: ColorPalette.primaryColor,fontSize: 16,overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 16,color: Colors.red,),
                                      SizedBox(width: 5),
                                      Text(booking['date'] ?? ""),
                                      SizedBox(width: 15),
                                      Icon(Icons.group, size: 16,color: Colors.red,),
                                      SizedBox(width: 5),
                                      Text(booking['staff'] ?? ""),
                                    ],
                                  ),


                                ],
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                // Navigate to booking details page
                              },
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            // SizedBox(height: 10),

                            ListTile(
                              title: Text(
                                "View Booking details",
                                style: TextStyle(color: Colors.black,fontSize: 16),
                              ) ,
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),

                            // SizedBox(height: 10),

                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            ),

            // Register Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add registration functionality
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
          ],
        ),
      ),
    );
  }
}