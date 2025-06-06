// ignore_for_file: unused_import
import 'package:flutter/material.dart';

/// GPA計算アルゴリズム
double GPA_calc(List<double> credits) {
  double gpTotal = 0; // GP × 単位数の合計
  double creditsTotal = 0; // 単位数の合計

  for (int i = 0; i < credits.length; i++) {
    final credit = credits[i]; // 入力値を数値に変換
    final gp = i.toDouble(); // GP値（インデックスをそのまま使用）

    if (credit >= 0) {
      gpTotal += gp * credit;
      creditsTotal += credit;
    }
  }

  // GPAを計算して返す（単位数が0の場合は0.0を返す）
  if (creditsTotal > 0) {
    return gpTotal / creditsTotal; // 単位数が0より大きい場合、GPAを計算して返す
  } else {
    return 0.0; // 単位数が0の場合は0.0を返す
  }
}