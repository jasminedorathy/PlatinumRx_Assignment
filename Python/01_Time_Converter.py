def convert_minutes(total_minutes):
    if total_minutes < 0:
        return "Invalid input: minutes cannot be negative."

    hours          = total_minutes // 60
    remaining_mins = total_minutes %  60

    if hours == 0:
        return f"{remaining_mins} minutes"
    elif hours == 1:
        return f"{hours} hr {remaining_mins} minutes"
    else:
        return f"{hours} hrs {remaining_mins} minutes"


if __name__ == "__main__":
    test_cases = [130, 110, 60, 45, 0, 90, 200, 1, 61, 120]

    print("=" * 40)
    print(" Time Conversion Results")
    print("=" * 40)
    for mins in test_cases:
        result = convert_minutes(mins)
        print(f"  {mins:>4} minutes  ->  {result}")
    print("=" * 40)

    print("\nEnter minutes to convert (type 'quit' to exit):")
    while True:
        user_input = input("  Minutes: ").strip()
        if user_input.lower() in ("quit", "q", "exit"):
            print("Goodbye!")
            break
        try:
            mins = int(user_input)
            print(f"  Result : {convert_minutes(mins)}\n")
        except ValueError:
            print("  Please enter a valid integer.\n")
