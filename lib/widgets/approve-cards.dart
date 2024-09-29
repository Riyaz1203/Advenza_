import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/theme.dart';

class ApproveCards extends StatefulWidget {
  final String docId;
  final String parkName;
  final String location;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;

  ApproveCards({
    required this.docId,
    required this.parkName,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  @override
  _ApproveCardsState createState() => _ApproveCardsState();
}

class _ApproveCardsState extends State<ApproveCards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width image at the top
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.parkName, style: AppTheme.headingStyle),
                SizedBox(height: 8),
                Text(widget.location, style: AppTheme.bodyTextStyle),
                SizedBox(height: 10),
                Text('\Rs:${widget.price} per ticket',
                    style: AppTheme.bodyTextStyle),
                SizedBox(height: 8),
                Text('Rating: ${widget.rating}', style: AppTheme.bodyTextStyle),
                SizedBox(height: 8),
                Text('Description: ${widget.description}',
                    style: AppTheme.bodyTextStyle),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool confirmApproval = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Approve ${widget.parkName}'),
                              content: Text(
                                  'Are you sure you want to approve this theme park?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Approve'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmApproval) {
                          await FirebaseFirestore.instance
                              .collection('approved_theme_park')
                              .doc(widget.docId)
                              .set({
                            'park_name': widget.parkName,
                            'park-location': widget.location,
                            'price': widget.price,
                            'image-link-1': widget.imageUrl,
                            'park_description': widget.description,
                            'rating': widget.rating,
                          });

                          await FirebaseFirestore.instance
                              .collection('theme_park')
                              .doc(widget.docId)
                              .delete();

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${widget.parkName} has been approved and moved.'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 42, 88, 42),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text('Approve',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // Show confirmation dialog for decline
                        bool confirmDecline = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Decline ${widget.parkName}'),
                              content: Text(
                                  'Are you sure you want to decline this theme park?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Decline'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmDecline) {
                          // Add park details to 'declined_park' collection
                          await FirebaseFirestore.instance
                              .collection('declined-park')
                              .doc(widget.docId) // Use the same document ID
                              .set({
                            'park_name': widget.parkName,
                            'park-location': widget.location,
                            'price': widget.price,
                            'image-link-1': widget.imageUrl,
                            'park_description': widget.description,
                            'rating': widget.rating,
                          });

                          // Remove from 'theme_park' collection
                          await FirebaseFirestore.instance
                              .collection('theme_park')
                              .doc(widget.docId)
                              .delete();

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${widget.parkName} has been declined and deleted.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text('Decline',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
