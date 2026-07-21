#!/usr/bin/env bash
# Called by lazygit (running inside a nvim :terminal) as its editor.
#
# Instead of quitting lazygit (what the built-in nvim-remote preset does), this
# hands the file+line to the PARENT nvim and HIDES lazygit, keeping the lazygit
# process alive so <leader>lg pops back to the exact same hunk.
#
# Wired via ~/.config/lazygit/config.yml:
#   os.edit       -> lazygit-edit.sh {{filename}}
#   os.editAtLine -> lazygit-edit.sh {{filename}} {{line}}
set -eu

file="${1:-}"
line="${2:-1}"

[ -z "$file" ] && exit 0

# Standalone lazygit (not launched from nvim): behave like a normal editor.
if [ -z "${NVIM:-}" ]; then
  exec nvim "+${line}" -- "$file"
fi

# Inside nvim: hand off to the parent instance. LazygitEdit() (defined in the
# lazygit plugin spec) hides the lazygit terminal and opens the file at the line.
# Double any single quotes so the name is safe inside a Vim single-quoted string.
esc_file=${file//\'/\'\'}
nvim --server "$NVIM" --remote-expr "v:lua.LazygitEdit('${esc_file}', ${line})" >/dev/null
