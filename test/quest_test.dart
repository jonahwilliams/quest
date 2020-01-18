// Copyright 2020 Jonah Williams. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

import 'package:quest/quest.dart';

void main() async {
  try {
    await testToBeAndNotToBe();
  } catch (err) {
    print(err);
    io.exitCode = -1;
  }
}

Future<void> testToBeAndNotToBe() async {
  expect(2).notToBe(3);
  expect(1).toBe(1);
  await expect(Future.value(2)).toBe(Future.value(2));
  await expect(Future.value(2)).notToBe(Future.value(3));
}
