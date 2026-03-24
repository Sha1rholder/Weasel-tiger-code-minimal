# Session Summary

## Goal

Extend this Rime Weasel configuration from a **tigress-only** setup to a setup that also supports **tiger** (single-character Tiger Code), while preserving the existing design goals:

- pure Simplified Chinese only
- no variant/traditional forms
- input behavior aligned with `tigress`
- candidate UI style aligned with `tigress`
- explicit and clean dependency structure

## What changed

### 1. Shared simplified whitelist was renamed and generalized

The old shared whitelist resource was named as if it belonged only to `tigress`:

- `tigress_simp_charset.dict.yaml`
- `tigress_simp_charset.schema.yaml`

It was renamed to:

- `tigers_simp_charset.dict.yaml`
- `tigers_simp_charset.schema.yaml`

And the internal identifiers were updated accordingly:

- `name: tigers_simp_charset`
- `schema_id: tigers_simp_charset`
- `translator/dictionary: tigers_simp_charset`

### 2. Lua filtering was refactored into a shared implementation

The simplified-character whitelist logic in `rime.lua` was turned into a shared implementation:

- shared reverse-db source: `build/tigers_simp_charset.reverse.bin`
- shared exported filter: `tigers_simp_filter`

Compatibility aliases were kept:

- `tigress_simp_filter = tigers_simp_filter`
- `tiger_simp_filter = tigers_simp_filter`

### 3. `tigress` was migrated to explicit shared dependencies

`tigress.custom.yaml` now explicitly depends on:

- `PY_c`
- `tigers_simp_charset`

And uses:

- `simplifier@only_simplified`
- `lua_filter@tigers_simp_filter`
- `only_simplified/opencc_config: t2s.json`

### 4. `tiger` was rebuilt to follow the same architecture

`tiger.custom.yaml` was rewritten to align with `tigress`:

- same simplified-only filter chain
- same shared charset dependency
- same `t2s.json` simplifier config
- same auto-select behavior
- same completion setting
- same UI style

### 5. Obsolete `tiger_simp` dictionary dependency was removed

`tiger.extended.dict.yaml` previously imported `tiger_simp`, which did not fit the chosen architecture.

This was removed so that:

- dictionary structure stays simple
- Simplified-only behavior is enforced by the filter pipeline
- the dependency model stays explicit and consistent

### 6. Git tracking was cleaned up

`.gitignore` was updated so `tiger` config files are no longer ignored. These files are now treated as normal project files.

### 7. Additional working-tree changes were committed later

At the user's request, later commits were intended to include all remaining changes as well, including files not directly part of the core refactor, such as:

- `default.custom.yaml`
- `tigress.extended.dict.yaml`
- `tiger.dict.yaml`
- `tiger.schema.yaml`

## Why these changes were made

### Shared resources should be named as shared resources

The simplified whitelist was already functionally shared by both `tiger` and `tigress`. Keeping a `tigress_*` name for a shared dependency would hide the real architecture and make future maintenance more confusing.

Renaming it to `tigers_*` makes the dependency graph honest.

### Filtering belongs in the filter layer, not in duplicate dictionaries

The chosen direction was to keep one explicit simplified-only filtering pipeline instead of creating or preserving extra dictionary variants such as `tiger_simp`.

This keeps responsibilities clean:

- dictionaries provide candidates
- filters enforce allowed output

### `tiger` and `tigress` should behave consistently

The user explicitly wanted `tiger` to follow `tigress` in:

- character set policy
- input behavior
- candidate presentation

So `tiger.custom.yaml` was rebuilt to mirror the effective `tigress` behavior rather than trying to preserve earlier ad hoc edits.

### Dependencies should be explicit

Both schemas now visibly depend on the shared whitelist schema. This makes the setup easier to understand for future maintainers and reviewers.

## Reviewer notes

### Important architectural point

The main architectural choice in this session was:

- **reuse one shared simplified whitelist resource**
- **reuse one shared Lua filter implementation**
- **apply the same filtering policy to both `tiger` and `tigress`**

If reviewing this change, evaluate it as a deliberate refactor toward shared infrastructure, not as a localized tiger-only patch.

### Minor notes

- Compatibility aliases remain in `rime.lua`:
  - `tigress_simp_filter`
  - `tiger_simp_filter`
  - both point to `tigers_simp_filter`

  These are intentionally retained to reduce breakage risk during transition. They can be removed later once all references are fully normalized.

- `tiger.extended.dict.yaml` no longer imports `tiger_simp`. This is intentional and matches the decision to enforce Simplified-only output through filters, not dictionary duplication.

- `tiger.custom.yaml` was rewritten rather than incrementally patched. This was intentional because earlier `tiger` changes were treated as non-authoritative; the goal was to make the structure correct.

### Operational note

After these changes, deployment/rebuild is important so Rime regenerates:

- `build/tigers_simp_charset.reverse.bin`

If old build artifacts remain, a clean rebuild may be helpful.

## Outcome

The resulting configuration is cleaner and more explicit:

- `tiger` and `tigress` both work under the same simplified-only policy
- shared resources are named and structured as shared resources
- UI and input behavior are aligned
- the dependency model is easier to reason about
- diagnostics were clean during the refactor phase
