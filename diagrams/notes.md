# Schema notes and entity relationships

Five tables. `student` and `course` are the two strong entities. `enrolment`
and `score` are the associative tables that resolve the many-to-many between
them. `instructor` hangs off `course` as a one-to-many.

```mermaid
erDiagram
    INSTRUCTOR ||--o{ COURSE : teaches
    STUDENT    ||--o{ ENROLMENT : registers
    COURSE     ||--o{ ENROLMENT : offered_in
    STUDENT    ||--o{ SCORE : earns
    COURSE     ||--o{ SCORE : assessed_in

    COURSE     ||--o{ SCORE : assessed_in
