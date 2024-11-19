def get_missing_number(input_array, n):
    end = n + 1
    total_sum = end * (end + 1) / 2
    s = sum(input_array)
    return int(total_sum - s)


if __name__ == "__main__":
    # Test cases
    test_cases = [
        {"input_array": [1], "n": 1, "expected": 2},  # Single element, missing last
        {"input_array": [1, 2, 4], "n": 3, "expected": 3},  # Small range, missing middle
        {"input_array": [2, 3, 4, 5], "n": 4, "expected": 1},  # Missing first
        {"input_array": [1, 2, 3, 4], "n": 4, "expected": 5},  # Missing last
        {"input_array": [1, 2, 4, 5], "n": 4, "expected": 3},  # Missing middle
        {"input_array": [1, 2, 3, 4, 6, 7, 8, 9, 10, 11], "n": 10, "expected": 5},  # Moderate size
        {"input_array": [4, 2, 1, 5], "n": 4, "expected": 3},  # Unordered input array
    ]

    # Run test cases
    for i, test in enumerate(test_cases):
        result = get_missing_number(test["input_array"], test["n"])
        print(f"Test Case {i + 1}: {'Passed' if result == test['expected'] else 'Failed'}")
        if result != test["expected"]:
            print(f"  Expected: {test['expected']}, Got: {result}")