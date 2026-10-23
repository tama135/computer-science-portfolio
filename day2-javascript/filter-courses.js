// filter-courses.js — filtering and shaping arrays without mutation.
// Run: node day2-javascript/filter-courses.js

const courses = [
  { code: 'WEB101', title: 'Web Fundamentals', credits: 6, level: 'intro',    seats: 12 },
  { code: 'CS201',  title: 'Data Structures',  credits: 8, level: 'core',     seats: 0  },
  { code: 'DB210',  title: 'Databases',        credits: 6, level: 'core',     seats: 7  },
  { code: 'JS110',  title: 'Scripting Basics', credits: 4, level: 'intro',    seats: 3  },
  { code: 'SEC300', title: 'Applied Security', credits: 8, level: 'advanced', seats: 2  },
];

// 1. Pure filter: no mutation, returns a new array.
const open = courses.filter((c) => c.seats > 0);

// 2. Chained shaping: filter, sort, then map to a display string.
const openByCredits = courses
  .filter((c) => c.seats > 0)
  .sort((a, b) => b.credits - a.credits || a.code.localeCompare(b.code))
  .map((c) => `${c.code} — ${c.title} (${c.credits} cr, ${c.seats} seats)`);

// 3. Grouping with reduce.
const byLevel = courses.reduce((acc, c) => {
  (acc[c.level] ??= []).push(c.code);
  return acc;
}, {});

// 4. Aggregation across the filtered set.
const openCredits = open.reduce((sum, c) => sum + c.credits, 0);

// 5. Reusable, independently testable predicate.
const hasSeats = (n) => (c) => c.seats >= n;
const twoOrMore = courses.filter(hasSeats(2));

console.log('Open courses:');
console.log(openByCredits.join('\n'));

console.log('\nCodes grouped by level:');
for (const [level, codes] of Object.entries(byLevel)) {
  console.log(`  ${level.padEnd(9)} ${codes.join(', ')}`);
}

console.log(`\nTotal credits still open: ${openCredits}`);
console.log(`Courses with 2 or more seats: ${twoOrMore.length}`);
