"""Summarise a set of scores: central tendency, spread, and band counts.

Run: python3 day3-python-java/scores_summary.py
"""

from statistics import mean, median

SCORES = [72, 81, 90, 65, 54, 88, 91, 47, 100, 63]

# Ordered highest floor first so the first match wins.
BANDS = ((85, "Distinction"), (70, "Merit"), (50, "Pass"), (0, "Fail"))


def band(score):
    """Return the band label. Lower bound inclusive, upper bound exclusive."""
    if not 0 <= score <= 100:
        raise ValueError(f"score out of range: {score}")
    for floor, label in BANDS:
        if score >= floor:
            return label
    return "Fail"


def summarise(scores):
    if not scores:
        raise ValueError("no scores to summarise")

    counts = {}
    for score in scores:
        label = band(score)
        counts[label] = counts.get(label, 0) + 1

    return {
        "n": len(scores),
        "mean": round(mean(scores), 1),
        "median": median(scores),
        "low": min(scores),
        "high": max(scores),
        "range": max(scores) - min(scores),
        "bands": counts,
    }


def main():
    summary = summarise(SCORES)
    for key in ("n", "mean", "median", "low", "high", "range"):
        print(f"{key:>7}: {summary[key]}")
    print("  bands:", ", ".join(f"{k}={v}" for k, v in sorted(summary["bands"].items())))

    print("\nband boundaries")
    for score in (0, 49, 50, 69, 70, 84, 85, 100):
        print(f"  {score:>3} -> {band(score)}")


if __name__ == "__main__":
    main()
