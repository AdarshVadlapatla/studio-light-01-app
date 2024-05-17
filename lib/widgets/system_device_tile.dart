import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SystemDeviceTile extends StatefulWidget {
  final BluetoothDevice device;
  final VoidCallback onOpen;
  final VoidCallback onConnect;

  const SystemDeviceTile({
    required this.device,
    required this.onOpen,
    required this.onConnect,
    Key? key,
  }) : super(key: key);

  @override
  State<SystemDeviceTile> createState() => _SystemDeviceTileState();
}

class _SystemDeviceTileState extends State<SystemDeviceTile> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription = widget.device.connectionState.listen((state) {
      _connectionState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }
  Widget _buildTitle(BuildContext context) {
  return GestureDetector(
     onTap: isConnected ? widget.onOpen : widget.onConnect,
    child: Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1), // Change the container color as needed
        borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text('Device Name', style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 10 // Adjust font weight as needed
                  ),),
                Text(
                  widget.device.platformName.isNotEmpty
                      ? widget.device.platformName
                      : 'Studio-Light-ofail',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Adjust font weight as needed
                  ),
                ),
                 Row(
                   children: [
                     Icon(Icons.battery_3_bar, color: Colors.green,),
                     Text('70% - 1h36m', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10 // Adjust font weight as needed
                  ),)
                   ],
                 ),
              ],
             
            ),
          ),
          Row(
            children: [
              Icon(Icons.arrow_forward, color: Colors.white,),
              
            ],
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildTitle(context),
      onTap: isConnected ? widget.onOpen : widget.onConnect,
      // subtitle: Text(widget.device.remoteId.str),
      // trailing: ElevatedButton(
      //   child: isConnected ? const Text('OPEN') : const Text('CONNECT'),
      //   onPressed: isConnected ? widget.onOpen : widget.onConnect,
      // ),
    );
  }
}
