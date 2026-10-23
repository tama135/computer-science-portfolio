import React from 'react';

export default function Header({ openCount, total }) {
  return (
    <header className="site-header">
      <h1>Course enrolment</h1>
      <p>
        <strong>{openCount}</strong> of {total} courses have seats available.
      </p>
    </header>
  );
}
