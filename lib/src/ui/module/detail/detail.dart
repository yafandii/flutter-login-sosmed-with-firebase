import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class DetailUSerArgument {
//   final User? user;

//   DetailUSerArgument({this.user});
// }

class DetailUSer extends StatefulWidget {
  static const String routeName = 'detail';

  final User? user;
  const DetailUSer({super.key, this.user});

  @override
  State<DetailUSer> createState() => _DetailUSerState();
}

class _DetailUSerState extends State<DetailUSer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.user?.photoURL ?? ""),
            ),
            const SizedBox(height: 10),
            Text("${widget.user?.email}"),
            const SizedBox(height: 5),
            Text("${widget.user?.displayName}"),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 100),
              ),
              onPressed: () {
                GoogleSignIn().disconnect();
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
