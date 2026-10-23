"""Classify a numeric score, with explicit boundary tests.

Run: python3 day3-python-java/classify.py
"""

FAIL, PASS, MERIT, DISTINCTION = "Fail", "Pass", "Merit", "Distinction"


def classify(score):
    """Band a score. Lower bound inclusive, upper bound exclusive.

    0-49 Fail, 50-69 Pass, 70-84 Merit, 85-100 Distinction.
    """
    if isinstance(score, bool) or not isinstance(score, (int, float)):
        raise TypeError(f"expected a number, got {type(score).__name__}")
    if score < 0 or score > 100:
        raise ValueError(f"score out of range: {score}")
    if score < 50:
        return FAIL
    if score < 70:
        return PASS
    if score < 85:
        return MERIT
    return DISTINCTION


def main():
    print("boundary table")
    for score in (0, 49, 50, 69, 70, 84, 85, 100):
        print(f"  {score:>3} -> {classify(score)}")

    print("\nout-of-range values")
    for bad in (-1, 101):
        try:
            classify(bad)
            print(f"  {bad:>3} -> no error (bug)")
        except ValueError as exc:
            print(f"  {bad:>3} -> {exc}")

    print("\nwrong type")
    try:
        classify("88")
    except TypeError as exc:
        print(f"  '88' -> {exc}")


if __name__ == "__main__":
    main()
