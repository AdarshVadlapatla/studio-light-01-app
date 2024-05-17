import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  @override
  State<ScanResultTile> createState() => _ScanResultTileState();
}

class _ScanResultTileState extends State<ScanResultTile> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription = widget.result.device.connectionState.listen((state) {
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

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]';
  }

  String getNiceManufacturerData(List<List<int>> data) {
    return data.map((val) => '${getNiceHexArray(val)}').join(', ').toUpperCase();
  }

  String getNiceServiceData(Map<Guid, List<int>> data) {
    return data.entries.map((v) => '${v.key}: ${getNiceHexArray(v.value)}').join(', ').toUpperCase();
  }

  String getNiceServiceUuids(List<Guid> serviceUuids) {
    return serviceUuids.join(', ').toUpperCase();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

 Widget _buildTitle(BuildContext context) {
 
  return GestureDetector(
     onTap: (widget.result.advertisementData.connectable) ? widget.onTap : widget.onTap,
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
                  widget.result.device.platformName.isNotEmpty
                      ? widget.result.device.platformName
                      : 'N/A',
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
  Widget _buildConnectButton(BuildContext context) {
    return ElevatedButton(
      child: isConnected ? const Text('OPEN') : const Text('CONNECT'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: (widget.result.advertisementData.connectable) ? widget.onTap : widget.onTap,
    );
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var adv = widget.result.advertisementData;
    return ListTile(
      title: _buildTitle(context),
    //  onTap: (widget.result.advertisementData.connectable) ? widget.onTap : widget.onTap,
      // leading: Text(widget.result.rssi.toString()),
      // trailing: _buildConnectButton(context),
      // children: <Widget>[
      //   if (adv.advName.isNotEmpty) _buildAdvRow(context, 'Name', adv.advName),
      //   if (adv.txPowerLevel != null) _buildAdvRow(context, 'Tx Power Level', '${adv.txPowerLevel}'),
      //   if ((adv.appearance ?? 0) > 0) _buildAdvRow(context, 'Appearance', '0x${adv.appearance!.toRadixString(16)}'),
      //   if (adv.msd.isNotEmpty) _buildAdvRow(context, 'Manufacturer Data', getNiceManufacturerData(adv.msd)),
      //   if (adv.serviceUuids.isNotEmpty) _buildAdvRow(context, 'Service UUIDs', getNiceServiceUuids(adv.serviceUuids)),
      //   if (adv.serviceData.isNotEmpty) _buildAdvRow(context, 'Service Data', getNiceServiceData(adv.serviceData)),
      // ],
    );
  }
}
