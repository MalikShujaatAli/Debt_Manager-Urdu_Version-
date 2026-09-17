# Qarz Manager — Urdu Debt Tracker

A **Flutter** app for tracking informal debts, built entirely in **Urdu**. Record who owes you and who
you owe, reorder the list by hand, and have it all persist between launches.

Written for people who keep these records on paper or in their head — which, where I am from, is most
people — so the whole interface is in the language they actually use.

---

## Stack

| | |
|---|---|
| Framework | Flutter (Dart) |
| State | `StatefulWidget` |
| Storage | `shared_preferences` — local, on-device |
| Extras | `ReorderableListView`, `url_launcher` |

## What it does

- **Add a debt** — amount, name, and which direction it goes (you owe / they owe)
- **Two separate ledgers** so the two directions never get confused
- **Reorder by dragging**, because the order that matters is whatever order you think in
- **Delete** when settled
- **Persists locally** via `shared_preferences`, so closing the app does not lose anything

Entirely Urdu-language UI, right-to-left.

---

## Running it

```bash
flutter pub get
flutter run
```

Single-file application — everything is in `main.dart`.

---

## Scope

An early project (2024) and small by design. Known limitations, in the order I would fix them:

- **`shared_preferences` is the wrong store for this.** It is a key-value cache, not a database; once the
  list grows or needs querying, this should be SQLite via `sqflite`.
- **No backup or export**, so a lost phone is a lost ledger.
- **No dates, no partial payments, no history** — a debt is a single current amount, not a running record.
- **All logic sits in one file** with no separation between UI and state.

## Built by

Malik Shujaat Ali — [github.com/MalikShujaatAli](https://github.com/MalikShujaatAli) ·
[linkedin.com/in/malik-shujaat-ali](https://www.linkedin.com/in/malik-shujaat-ali)
