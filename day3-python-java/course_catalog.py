"""A small in-memory course catalogue with enrolment guards.

Run: python3 day3-python-java/course_catalog.py
"""

from dataclasses import dataclass, field


@dataclass
class Course:
    code: str
    title: str
    credits: int
    capacity: int
    enrolled: list = field(default_factory=list)

    def __post_init__(self):
        if not 1 <= self.credits <= 12:
            raise ValueError(f"{self.code}: credits must be 1-12, got {self.credits}")
        if self.capacity < 1:
            raise ValueError(f"{self.code}: capacity must be positive")

    @property
    def seats_left(self):
        return self.capacity - len(self.enrolled)

    def enrol(self, student):
        if self.seats_left <= 0:
            raise ValueError(f"{self.code} is full")
        if student in self.enrolled:
            raise ValueError(f"{student} is already on {self.code}")
        self.enrolled.append(student)

    def __str__(self):
        return f"{self.code:<7} {self.title:<20} {len(self.enrolled)}/{self.capacity}"


CATALOGUE = {
    c.code: c
    for c in (
        Course("WEB101", "Web Fundamentals", 6, 30),
        Course("CS201", "Data Structures", 8, 25),
        Course("DB210", "Databases", 6, 3),
    )
}


def main():
    CATALOGUE["WEB101"].enrol("R. Patel")
    CATALOGUE["DB210"].enrol("S. Nakamura")
    CATALOGUE["DB210"].enrol("T. Bello")

    print("catalogue")
    for course in CATALOGUE.values():
        print(" ", course)

    print("\nguard checks")
    checks = (
        ("duplicate enrol", lambda: CATALOGUE["WEB101"].enrol("R. Patel")),
        ("fill to capacity", lambda: CATALOGUE["DB210"].enrol("A. Okafor")),
        ("over capacity", lambda: CATALOGUE["DB210"].enrol("M. Lindqvist")),
        ("bad credits", lambda: Course("XX1", "Bad", 40, 10)),
    )
    for label, fn in checks:
        try:
            fn()
            print(f"  {label:<18} accepted")
        except ValueError as exc:
            print(f"  {label:<18} {exc}")


if __name__ == "__main__":
    main()
