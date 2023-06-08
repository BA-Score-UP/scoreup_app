import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  final String microSubject;
  final double percentage;
  final double spacing;

  const ItemBox({
    Key? key,
    required this.microSubject,
    required this.percentage,
    this.spacing = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[350],
          ),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '$microSubject:',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Desempenho:'),
                  SizedBox(height: (spacing / 2)),
                  Row(
                    children: [
                      Text('${(percentage * 100).ceil().toString()}%'),
                      SizedBox(width: (spacing * 2)),
                      Expanded(
                        child: LinearProgressIndicator(
                          color: Colors.green,
                          minHeight: 12,
                          value: percentage,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: spacing * 2),
      ],
    );
  }
}