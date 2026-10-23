# JavaScript glossary

Terms used across the Day 2 exercises, with a minimal example each.

## closure
A function that keeps a reference to the scope it was defined in, even after
that scope has returned.

    const counter = () => { let n = 0; return () => ++n; };
    const next = counter();
    next(); // 1
    next(); // 2

## hoisting
Declarations are moved to the top of their scope before execution. `var` and
function declarations hoist. `let` and `const` are hoisted but sit in a
temporal dead zone until initialised.

## event delegation
Attaching one listener to a common ancestor instead of one per child, then
using `event.target.closest()` to work out which child fired.

## this
Resolved at call time, not definition time, for regular functions. Arrow
functions capture `this` lexically and are the safer choice in callbacks.

## debounce
Collapse a burst of calls into one, fired after the burst stops. Used on
`input` handlers so validation does not run on every keystroke.

## truthy and falsy
Everything is truthy except `false`, `0`, `-0`, `0n`, `""`, `null`, `undefined`
and `NaN`. Prefer an explicit check over relying on this.

## spread and rest
`...` expands an iterable in a call or array literal, and collects remaining
arguments in a parameter list. Both produce new values rather than mutating.

    const merged = { ...defaults, ...overrides };

## destructuring
Unpacking values from arrays or properties from objects into named bindings.
Works in parameters, which is how props get read in React.

## strict equality
`===` compares without coercion. `==` coerces, so `"1" == 1` is `true`. Use
`===` unless you have a reason not to.

## event loop
The mechanism that drains the microtask queue, then the macrotask queue, after
the current synchronous frame. Promises resolve on the microtask queue.

## pure function
Same input, same output, no side effects. Mutating inside a `filter` callback
is the classic mistake.

## prototype chain
Property lookups walk from the object up through its prototype until they hit
`null`. `Object.create(null)` gives an object with no prototype at all.

## null versus undefined
`undefined` means "not assigned". `null` means "deliberately empty". Optional
chaining `?.` and `??` handle both without a truthiness check.
