import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DocLogin extends StatefulWidget {
  const DocLogin({super.key});

  @override
  State<DocLogin> createState() => _DocLoginState();
}

class _DocLoginState extends State<DocLogin> {
  PlatformFile? pickedFile;
  String file = 'empty';
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      file = pickedFile!.name.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Container(
            padding: EdgeInsets.all(8),
            // color: Colors.amber,
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            // width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      selectFile();
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      size: 40,
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  padding: EdgeInsets.all(8),
                  // color: Colors.red,
                  width: 200,
                  height: 30,
                  child: Text(
                    file == 'empty' ? 'No file selected' : file,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, fixedSize: Size(200, 20)),
              child: Text('Scan and SignUp')),
          SizedBox(
            height: 60,
          ),
          Text(
            '- Already have an Account -',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, fixedSize: Size(200, 20)),
              child: Text('Login')),
        ],
      ),
    );
  }
}
