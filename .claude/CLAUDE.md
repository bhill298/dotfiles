# Global Agents File

## Revision Control / Git

- **Scope**: Ask before making changes unrelated to the task requested, like random formatting changes, refactoring, or "improvements" that aren't part of the explicit request. Goal: keep revision control commit diffs clean and focused only on changes relevant to the commit message. THIS IS NOT OPTIONAL: DO NOT MAKE UNRELATED RANDOM WHITESPACE OR FORMATTING CHANGES IRRELEVANT TO THE REQUESTED TASK WITHOUT ASKING FIRST.
- **Authoring commits**: When committing changes as the user, do so without adding yourself as a co-author. Use the user's identity for commits, not the agent's.
- **Whitespace**: Remove all trailing whitespace before committing. Verify with git diff --check if available.

## Testing and Verification

- Always test changes if possible and applicable.
- Verify correct syntax and ensure there are no build or lint errors before considering a task complete.
- Run relevant tests, linters, type checkers, or build processes as appropriate for the codebase.
