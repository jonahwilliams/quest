// Copyright 2020 Jonah Williams. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// An expectation allows ...
class Expectation<T> {
  Expectation._(this.value);

  /// The value that is being evaluated in this expectation.
  final T value;
}

/// Create an expectation for ....
Expectation<T> expect<T>(T value) => Expectation._(value);

/// A universal set of matchers.
extension Matchers<T> on Expectation<T> {
  /// Assert that the expected value is equal to the [candidate] value.
  ///
  /// Equality is determined using `operator==`.
  void toBe(T candidate) {
    if (value != candidate) {
      throw Exception('$value is not $candidate.');
    }
  }

  /// Assert that the expected value is not equal to the [candidate] value.
  ///
  /// Inequality is determined using `operator==`.
  void notToBe(T candidate) {
    if (value == candidate) {
      throw Exception('$value is $candidate.');
    }
  }
}

/// A set of matchers for async values.
extension AsyncMatchers<T> on Expectation<Future<T>> {
  /// Assert that the resolved expected value is equal to the resolved
  /// [candidate] value.
  Future<void> toBe(Future<T> candidate) async {
    final List<T> values = await Future.wait([value, candidate]);
    if (values[0] != values[1]) {
      throw Exception('${values[0]} is not ${values[1]}.');
    }
  }

  /// Assert that the resolved expected value is not equal to the resolved
  /// [candidate] value.
  ///
  /// Inequality is determined using `operator==`.
  Future<void> notToBe(Future<T> candidate) async {
    final List<T> values = await Future.wait([value, candidate]);
    if (values[0] == values[1]) {
      throw Exception('${values[0]} is ${values[1]}.');
    }
  }
}
