import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SolutionPage extends StatefulWidget {
  static const routeName = '/solution';

  const SolutionPage({Key? key}) : super(key: key);

  @override
  _SolutionPageState createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              SolutionPage.routeName,
            );
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          child: Text('ดูผล', style: Theme.of(context).textTheme.bodyText2),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/vote_hand.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        'EXIT POLL',
                        style: GoogleFonts.mali(
                            fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "เลือกตั้ง อบต.",
                    style:
                    GoogleFonts.mali(fontSize: 30.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "รายชื่อผู้สมัครรับเลือกตั้ง",
                    style:
                    GoogleFonts.mali(fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "นายกองค์การบริหารส่วนตำบลเขาพระ",
                    style:
                    GoogleFonts.mali(fontSize: 15.0, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "อำเภอเมืองนครนายก จังหวัดนครนายก",
                    style:
                    GoogleFonts.mali(fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ],
            )));
  }
}
