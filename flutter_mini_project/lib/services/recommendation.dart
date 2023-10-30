import 'dart:convert';


import 'package:flutter_mini_project/models/open_ai_models.dart';
import 'package:flutter_mini_project/utils/open_ai_constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FinancialPlannerService {
  static Future<GptData> getRecommendation({
    required String salary,
   
  }) async {
    late GptData gptData = GptData(
      warning: "",
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
    );

    try {
      var url = Uri.parse('https://api.openai.com/v1/completions');
      Map<String, String> headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer ${OpenAIConstant.apiKey}',
      };

      final formatCurrency = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'IDR ',
        decimalDigits: 0,
      );

      String monthlySalary = formatCurrency.format(int.parse(salary));

      String promptData =
          "You are a Financial planner. Please give me as a financial planner with budget equals to $monthlySalary";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "temperature": 0.4,
        "max_tokens": 64,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      });

      final response = await http.post(url, headers: headers , body: data);
      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      }
    } catch (e) {
      throw Exception('Error Occured saat mengirim request');
    }

    return gptData;
  }
}
