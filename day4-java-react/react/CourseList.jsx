import React from 'react';
import CourseCard from './CourseCard.jsx';

export default function CourseList({ courses, onEnrol }) {
  if (courses.length === 0) {
    return <p className="empty">No courses match the current filter.</p>;
  }

  return (
    <ul className="course-list">
      {courses.map((course) => (
        <li key={course.id}>
          <CourseCard course={course} onEnrol={onEnrol} />
        </li>
      ))}
    </ul>
  );
}
