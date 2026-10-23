import React, { useState } from 'react';
import Header from './Header.jsx';
import CourseList from './CourseList.jsx';

const INITIAL_COURSES = [
  { id: 1, code: 'WEB101', title: 'Web Fundamentals', credits: 6, seats: 12 },
  { id: 2, code: 'CS201', title: 'Data Structures', credits: 8, seats: 0 },
  { id: 3, code: 'DB210', title: 'Databases', credits: 6, seats: 7 },
];

export default function App() {
  const [courses, setCourses] = useState(INITIAL_COURSES);
  const [onlyOpen, setOnlyOpen] = useState(false);

  const visible = onlyOpen ? courses.filter((c) => c.seats > 0) : courses;

  // Functional update so the reducer never reads a stale array.
  function enrol(id) {
    setCourses((prev) =>
      prev.map((c) =>
        c.id === id && c.seats > 0 ? { ...c, seats: c.seats - 1 } : c,
      ),
    );
  }

  const openCount = courses.filter((c) => c.seats > 0).length;

  return (
    <div className="app">
      <Header openCount={openCount} total={courses.length} />

      <label className="filter">
        <input
          type="checkbox"
          checked={onlyOpen}
          onChange={(event) => setOnlyOpen(event.target.checked)}
        />
        {' '}Only show courses with seats
      </label>

      <CourseList courses={visible} onEnrol={enrol} />
    </div>
  );
}
