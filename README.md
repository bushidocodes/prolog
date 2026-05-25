# Prolog Examples

A small collection of Prolog programs illustrating facts, rules, and constraint solving.

## Prerequisites

Install [SWI-Prolog](https://www.swi-prolog.org/) (version 10+):

```powershell
# Windows (winget)
winget install SWI-Prolog.SWI-Prolog
```

```bash
# macOS
brew install swi-prolog

# Ubuntu/Debian
sudo apt install swi-prolog
```

After installation, `swipl` will be on your PATH (you may need to restart your terminal).

## Running Programs

### Interactive REPL

Load a file into the interactive interpreter and type queries at the `?-` prompt:

```bash
swipl friends.pl
```

```prolog
?- friend(wallace, grommit).
true.

?- halt.
```

### Script / Batch Mode

Use `-g` to run a goal non-interactively and `-t halt` to exit when done:

```bash
swipl -q -l friends.pl -g "friend(wallace, grommit), write(true)" -t halt
```

The `-q` flag suppresses the startup banner.

---

## Files

### `friends.pl` — Facts, Rules, and Negation

Defines `likes/2` facts and a `friend/2` rule using negation-as-failure (`\+`).

```prolog
likes(wallace, cheese).
likes(grommit, cheese).
likes(wendolene, sheep).

friend(X, Y) :- \+(X = Y), likes(X, Z), likes(Y, Z).
```

**Interactive queries:**

```prolog
?- friend(wallace, grommit).
true.

?- friend(grommit, wallace).
true.

?- friend(wallace, wendolene).
false.

?- likes(wallace, What).
What = cheese.
```

> **Note:** Querying `friend(X, Y).` with unbound variables returns no results because `\+(X = Y)` fails when both `X` and `Y` are uninstantiated (they unify with each other). Bind the variables through `likes/2` first if you want to enumerate all pairs:
> ```prolog
> ?- likes(X, _), likes(Y, _), friend(X, Y).
> ```

---

### `food.pl` — Chained Rules

Demonstrates multi-step inference: `food_type` + `flavor` facts → `food_flavor` rule.

```prolog
food_type(velveeta, cheese).  food_flavor(X, Y) :- food_type(X, Z), flavor(Y, Z).
flavor(savory, cheese).
flavor(savory, meat).
flavor(sweet, dessert).
flavor(sweet, soda).
```

**Interactive queries:**

```prolog
?- food_flavor(spam, What).
What = savory.

?- food_flavor(twinkie, What).
What = sweet.

?- food_flavor(What, sweet).
What = jolt ;
What = twinkie.

?- food_flavor(X, Y).
X = velveeta, Y = savory ;
X = spam,     Y = savory ;
X = sausage,  Y = savory ;
X = jolt,     Y = sweet  ;
X = twinkie,  Y = sweet.
```

> `ritz` has no flavor because `flavor(_, cracker)` is not defined in the knowledge base.

---

### `map.pl` — Constraint / Map Coloring

Uses Prolog's search to find a valid 3-coloring of five neighboring US states.

```prolog
different(red, green). different(red, blue).
different(green, red). different(green, blue).
different(blue, red).  different(blue, green).
```

**Interactive queries:**

```prolog
?- coloring(Alabama, Mississippi, Georgia, Tennessee, Florida).
Alabama = blue,
Mississippi = red,
Georgia = red,
Tennessee = green,
Florida = green ;
...
```

Press `;` to see the next solution, or `.` to stop.

---

### `ohmy.pl` — Unification and Pattern Matching

Illustrates unification (`=`) and generating combinations.

```prolog
cat(lion).  cat(tiger).

dorothy(X, Y, Z) :- X = lion, Y = tiger, Z = bear.
twin_cats(X, Y) :- cat(X), cat(Y).
```

**Interactive queries:**

```prolog
?- dorothy(X, Y, Z).
X = lion,
Y = tiger,
Z = bear.

?- twin_cats(X, Y).
X = lion, Y = lion ;
X = lion, Y = tiger ;
X = tiger, Y = lion ;
X = tiger, Y = tiger.

?- cat(lion).
true.
```
