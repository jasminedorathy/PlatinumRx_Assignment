def remove_duplicates(input_string):
    result = ""

    for char in input_string:
        if char not in result:
            result += char

    return result


if __name__ == "__main__":
    test_cases = [
        "programming",
        "hello world",
        "aabbcc",
        "PlatinumRx",
        "data analyst",
        "mississippi",
        "abcabc",
        "aaaa",
        "",
        "a",
    ]

    print("=" * 50)
    print("  Remove Duplicate Characters")
    print("=" * 50)
    for text in test_cases:
        result = remove_duplicates(text)
        display_input = f'"{text}"' if text else '""  (empty)'
        print(f"  Input  : {display_input}")
        print(f"  Output : \"{result}\"")
        print()
    print("=" * 50)

    print("\nEnter a string to remove duplicates (type 'quit' to exit):")
    while True:
        user_input = input("  String: ")
        if user_input.lower() in ("quit", "q", "exit"):
            print("Goodbye!")
            break
        result = remove_duplicates(user_input)
        print(f"  Result: \"{result}\"\n")
