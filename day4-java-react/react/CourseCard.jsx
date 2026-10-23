import React from 'react';

// Presentational: reads props, renders, raises events upward. Holds no state.
export default function CourseCard({ course, onEnrol }) {
  const { id, code, title, credits, seats } = course;
  const isFull = seats === 0;

  return (
    <article className="card" aria-labelledby={`title-${id}`}>
      <h2 id={`title-${id}`}>{title}</h2>
      <p className="meta">
        <span className="code">{code}</span>
        {' · '}
        {credits} credits
        {' · '}
        {isFull ? 'full' : `${seats} seats left`}
      </p>
      <button type="button" onClick={() => onEnrol(id)} disabled={isFull}>
        {isFull ? 'Full' : 'Enrol'}
      </button>
    </article>
  );
}
