import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fones de ouvido'),
            Row(
              children: [
                Chip(
                  label: Text('14/jan - 18h'),
                  color: WidgetStatePropertyAll(Color(0xFFF8FAFE)),
                  avatar: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('Perdido'),
                  color: WidgetStatePropertyAll(Color(0xFFF8FAFE)),
                  avatar: Icon(
                    Icons.dashboard,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 15,
                  color: Theme.of(context).hintColor,
                ),
                Text(
                  'Refeitório',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      width: .5,
                      color: const Color.fromARGB(255, 187, 187, 187),
                    ),
                  ),
                  child: Icon(Icons.headphones),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Fones de ouvido rosa perdido no refeitório. No dia 14/01.',
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
}
