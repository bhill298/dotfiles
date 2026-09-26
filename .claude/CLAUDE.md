# Global Agents File

## Revision Control / Git

- **Author identity**: When committing changes as the user, do so as the user's configured project or global identity without adding yourself as a co-author. If none is configured, ask.
- **Committing changes**: Unless instructed otherwise, commit task-related changes when the task is complete. Keep commits focused. Avoid unrelated fixes or formatting changes. If unrelated fixes or formatting changes are explicitly requested, commit them separately. Do not commit, discard, or modify unrelated pre-existing changes. If task changes overlap with existing uncommitted edits and cannot be cleanly separated, ask before committing.
- **Commit messages**: The top line is a brief summary (aim for 50 characters or fewer with a max of 72), followed by a blank line and a more detailed description of the changes (optional, if needed for more info or context) wrapped to a max of 72 characters. Write top-line summaries in the imperative, describing what applying this commit does (e.g. Add null pointer checks).
- **.gitignore**: Create or update `.gitignore` as needed to exclude generated and temporary project files. Do not commit temporary files, build artifacts, temporary tool output / working artifacts unless there is a specific reason to. Commit source code, documentation, tests, and supporting files needed to build, run, and maintain the project.
- **Pushing**: Do not automatically push unless asked or more specific instructions say otherwise. If you need to test, e.g., workflows or CI pipelines that run on the remote, ask before pushing so you can iterate until these things work, like you would with normal tests.
- **Whitespace**: Remove trailing whitespace from lines changed for the task. Verify with something like `git diff --check` (add `--cached` for staged changes) before committing.

## Testing and Verification

- Run tests, linters, type checks, and builds relevant to the changes, following the project’s documented validation steps.
- Fix failures introduced by your changes before considering the task complete. Unrelated, pre-existing failures and failures due to unavailable services, missing credentials, or similar environmental limitations do not prevent committing completed changes. Report those failures to the user.
