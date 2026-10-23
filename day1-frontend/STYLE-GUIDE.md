# Style guide

## Principles

1. **Tokens first.** No raw hex, no magic pixel values in components. If a value
   is not in `_tokens.scss`, add it there before you use it.
2. **Mobile-first.** Base styles target the narrowest viewport. Everything else
   is a `min-width` override. Never write a `max-width` media query.
3. **Semantics before styling.** If a `div` is doing a `section`'s job, the bug
   is in the markup, not the CSS.
4. **Focus is never removed.** `:focus-visible` gets a 3px accent ring.

## Colour

| Token | Value | Use |
|---|---|---|
| `$colour-ink` | `#14161a` | Body text |
| `$colour-ink-soft` | `#4a515c` | Secondary text, metadata |
| `$colour-surface` | `#ffffff` | Page background |
| `$colour-surface-alt` | `#f4f6f9` | Cards, raised panels |
| `$colour-accent` | `#1f5fdb` | Links, primary buttons |
| `$colour-accent-ink` | `#ffffff` | Text on accent |
| `$colour-border` | `#d9dee6` | Hairlines, card outlines |

Contrast: `$colour-ink` on `$colour-surface` is about 15.8:1.
`$colour-accent-ink` on `$colour-accent` is about 5.4:1. Both clear WCAG AA.

## Type scale

1.25 ratio from a 1rem base: `$step-0` 1rem, `$step-1` 1.25rem,
`$step-2` 1.563rem, `$step-3` 1.953rem.

One `h1` per page. Never skip a level, so `h2` straight to `h4` is a bug.

## Space scale

`$space-1` (0.25rem) through `$space-6` (4rem). Use the scale. Do not invent
`13px`.

## Layout

Single column by default. The card grid becomes three columns at 48rem via the
`from()` mixin.

## File structure

| File | Role |
|---|---|
| `styles.scss` | Entry point. Imports partials, composes components. |
| `_tokens.scss` | Colour, type, space, breakpoints, token emitter. |
| `_mixins.scss` | `heading`, `focus-ring`, `flex-row`, `from`, `at`. |
| `styles.css` | Compiled output. Do not hand-edit. |
| `index.html` | Reference implementation. |

## Build

    sass day1-frontend/styles.scss day1-frontend/styles.css

## Adding a component

1. Add any new values to `_tokens.scss`.
2. If a pattern repeats twice, extract a mixin into `_mixins.scss`.
3. Add the component to `styles.scss`.
4. Recompile and check at 320px, 768px and 1440px.
