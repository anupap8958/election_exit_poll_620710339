import 'dart:convert';

import 'package:election_exit_poll_620710339/models/candidateItem.dart';
import 'package:election_exit_poll_620710339/pages/solution_page.dart';
import 'package:election_exit_poll_620710339/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Candidate>> _candidateFuture;

  Future<void> _election(int candidateNumber) async {
    var elector =
        (await Api().submit('exit_poll', {'candidateNumber': candidateNumber}));
    _showMaterialDialog('SUCCESS', 'บันทึกข้อมูลสำเร็จ ${elector.toString()}');
  }

  _handleClickCandidate(Candidate candidate) {
    _election(candidate.candidateNumber);
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText1),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _candidateFuture = _fetch();
  }

  Future<List<Candidate>> _fetch() async {
    List list = await Api().fetch('exit_poll');
    var candidate = list.map((item) => Candidate.fromJson(item)).toList();
    print("asd " + candidate.toString());
    return candidate;
  }

  Widget _buildCandidateCard(BuildContext context) {
    return FutureBuilder<List<Candidate>>(
      future: _candidateFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          var candidateList = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: candidateList!.length,
            itemBuilder: (BuildContext context, int index) {
              var candidate = candidateList[index];

              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.all(8.0),
                elevation: 5.0,
                shadowColor: Colors.black.withOpacity(0.2),
                color: Colors.white.withOpacity(0.5),
                child: InkWell(
                  onTap: () => _handleClickCandidate(candidate),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            '${candidate.candidateNumber}',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${candidate.candidateTitle} ${candidate.candidateFirstName} ${candidate.candidateLastName}',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ผิดพลาด: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _candidateFuture = _fetch();
                    });
                  },
                  child: const Text('ลองใหม่'),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

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
          child: Text('ดูผล'),
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
                _buildCandidateCard(context),
              ],
            )));
  }
}
