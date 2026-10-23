// flashcard-quiz.js — quiz state machine.
// Pure engine, runs under node:  node day2-javascript/flashcard-quiz.js
// Attaches to the DOM only when a document exists.

const DECK = [
  { q: 'What does Array.prototype.filter return?', a: 'A new array with the items that passed the test.' },
  { q: 'Which operator compares without coercion?', a: '===' },
  { q: 'What is a closure?', a: 'A function that keeps a reference to its defining scope.' },
  { q: 'What does event delegation replace?', a: 'One listener per child, with a single listener on an ancestor.' },
  { q: 'Name the falsy values.', a: 'false, 0, -0, 0n, "", null, undefined, NaN.' },
];

function createQuiz(deck, shuffle = true) {
  const cards = shuffle ? [...deck].sort(() => Math.random() - 0.5) : [...deck];

  let index = 0;
  let correct = 0;
  const missed = [];

  return {
    get done() { return index >= cards.length; },
    get position() { return `${Math.min(index + 1, cards.length)}/${cards.length}`; },
    get current() { return cards[index] ?? null; },
    get score() { return correct; },
    get missed() { return [...missed]; },

    answer(text) {
      if (this.done) return null;
      const card = cards[index];
      const normalise = (s) => s.trim().toLowerCase().replace(/[.\s]+$/, '');
      const right = normalise(text) === normalise(card.a);
      if (right) correct += 1;
      else missed.push(card);
      index += 1;
      return right;
    },
  };
}

// --- node demo ---
if (typeof document === 'undefined') {
  const quiz = createQuiz(DECK, false);

  while (!quiz.done) {
    const card = quiz.current;
    const giving = quiz.position.startsWith('1') || quiz.position.startsWith('3')
      ? card.a
      : 'nope';

    const right = quiz.answer(giving);
    console.log(`${quiz.position} ${right ? 'correct' : 'wrong  '} — ${card.q}`);
  }

  console.log(`\nscore: ${quiz.score}/${DECK.length}`);
  console.log(`missed: ${quiz.missed.length}`);
}

// --- browser wiring ---
if (typeof document !== 'undefined') {
  const quiz = createQuiz(DECK);
  const question = document.getElementById('question');
  const answer = document.getElementById('answer');
  const feedback = document.getElementById('feedback');

  function render() {
    if (quiz.done) {
      question.textContent = `Done. Score ${quiz.score}/${DECK.length}.`;
      answer.disabled = true;
      return;
    }
    question.textContent = `${quiz.position} — ${quiz.current.q}`;
  }

  document.getElementById('check').addEventListener('click', () => {
    const right = quiz.answer(answer.value);
    if (right === null) return;
    feedback.textContent = right ? 'Correct.' : 'Not quite.';
    answer.value = '';
    render();
  });

  render();
}
