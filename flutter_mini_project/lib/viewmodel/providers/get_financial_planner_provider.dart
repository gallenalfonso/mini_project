import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/open_ai_models.dart';
import 'package:flutter_mini_project/services/recommendation.dart';

class GetFinancialPlannerProvider extends ChangeNotifier {
  final TextEditingController salaryController = TextEditingController();

  bool isLoading = false;

  GptData? gptResponseData;

  void getrecommendation() async {
    isLoading = true;
    try {
      gptResponseData = await FinancialPlannerService.getRecommendation(
        salary: salaryController.value.text,
      );
      // if (mounted) {
      //   setState(() {
      //     isLoading = true;
      //   });
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) {
      //         return ResultPage(gptResponseData: result);
      //       },
      //     ),
      //   );
      // }
      notifyListeners();
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Failed to send request , Try Again'),
      );
      notifyListeners();

      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
