import 'package:flutter/material.dart';
import 'package:flutter_mini_project/providers/get_financial_planner_provider.dart';

import 'package:provider/provider.dart';

class GetFinancialPlannerScreen extends StatefulWidget {
  const GetFinancialPlannerScreen({super.key});

  @override
  State<GetFinancialPlannerScreen> createState() =>
      _GetFinancialPlannerScreenState();
}

class _GetFinancialPlannerScreenState extends State<GetFinancialPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    final financialProvider =
        Provider.of<GetFinancialPlannerProvider>(context, listen: false);
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Financial Planner"),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Enter your Monthly Salary'),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter in Rupiah type',
                  border: OutlineInputBorder(),
                ),
                controller: financialProvider.salaryController,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: financialProvider.isLoading != false
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          financialProvider.getrecommendation();
                        },
                        child: const Text('Show Recommendation'),
                      ),
              ),
              Consumer<GetFinancialPlannerProvider>(
                builder: (context, provider, _) {
                  if (provider.gptResponseData != null) {
                    return Text(
                        provider.gptResponseData?.choices[0].text ?? " ",
                        textAlign: TextAlign.justify);
                  } else {
                    return const Icon(Icons.dangerous);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
