# Vim Motions & Keybindings Cheat Sheet

Complete reference of all keybindings and motions demonstrated in Omerxx's video (*Give Me 20 Minutes and I'll Make You a Vim Motions Expert*).

---

## 1. Modes & Insertion

| Key | Mode / Scope | Action |
| :--- | :--- | :--- |
| `i` | Normal | Enter Insert mode before cursor |
| `I` | Normal | Enter Insert mode at beginning of line text |
| `a` | Normal | Enter Insert mode after cursor (append) |
| `A` | Normal | Enter Insert mode at end of line (append) |
| `o` | Normal | Open new line below and enter Insert mode |
| `O` | Normal | Open new line above and enter Insert mode |
| `jj` / `jk` | Insert | Fast exit to Normal mode (configured shortcut) |
| `<Esc>` | Insert / Visual | Return to Normal mode |
| `r` | Normal | Replace single character under cursor |
| `R` | Normal | Enter Replace mode (overwrite text) |

---

## 2. In-Line & Word Motions

| Key | Mode | Action |
| :--- | :--- | :--- |
| `h` / `j` / `k` / `l` | Normal / Visual | Left / Down / Up / Right |
| `w` | Normal / Visual | Jump forward to start of next word |
| `b` | Normal / Visual | Jump backward to start of previous word |
| `e` | Normal / Visual | Jump forward to end of word |
| `W` / `B` / `E` | Normal / Visual | Jump by whitespace-delimited WORD |
| `B` | Normal / Visual | Jump to start of line text (mapped to `^`) |
| `E` | Normal / Visual | Jump to end of line (mapped to `$`) |
| `0` | Normal / Visual | Jump to absolute start of line (column 0) |
| `^` | Normal / Visual | Jump to first non-blank character of line |
| `$` | Normal / Visual | Jump to end of line |
| `f{char}` | Normal / Visual | Find and jump forward to `{char}` on current line |
| `F{char}` | Normal / Visual | Find and jump backward to `{char}` on current line |
| `;` | Normal / Visual | Repeat last `f`/`F` search forward |
| `,` | Normal / Visual | Repeat last `f`/`F` search backward |
| `[count][motion]` | Normal / Visual | Repeat motion `[count]` times (e.g. `4ft`, `5w`, `6k`) |

---

## 3. Document Navigation & Viewport

| Key | Mode | Action |
| :--- | :--- | :--- |
| `gg` | Normal / Visual | Jump to first line of document |
| `G` | Normal / Visual | Jump to last line of document |
| `[line]G` | Normal / Visual | Jump directly to line number `[line]` |
| `zz` | Normal | Center current line in viewport |
| `H` | Normal / Visual | Jump to High (top line of visible screen) |
| `M` | Normal / Visual | Jump to Middle of visible screen |
| `L` | Normal / Visual | Jump to Low (bottom line of visible screen) |
| `%` | Normal / Visual | Jump to matching bracket, parenthesis, or brace |

---

## 4. Editing, Deleting & Changing (Operators)

| Key | Mode | Action |
| :--- | :--- | :--- |
| `d{motion}` | Normal | Delete target motion (e.g. `dw`, `d$`, `d6k`) |
| `dd` | Normal | Delete entire line |
| `D` | Normal | Delete from cursor to end of line |
| `c{motion}` | Normal | Change target motion (deletes and enters Insert mode) |
| `cw` / `ce` | Normal | Change word |
| `cc` | Normal | Change entire line |
| `C` | Normal | Change from cursor to end of line |
| `==` | Normal | Auto-indent current line |
| `=` in Visual | Visual | Auto-indent selected block |
| `u` | Normal | Undo last change |
| `<C-r>` | Normal | Redo last undone change |
| `.` | Normal | Repeat last change (dot operator) |

---

## 5. Text Objects & Surroundings

| Key | Scope | Action |
| :--- | :--- | :--- |
| `diw` / `ciw` | Inside Word | Delete / Change inside current word |
| `daw` / `caw` | Around Word | Delete / Change word including surrounding whitespace |
| `di(` / `ci(` | Inside Parentheses | Delete / Change inside `(...)` |
| `da(` / `ca(` | Around Parentheses | Delete / Change `(...)` including outer parentheses |
| `di"` / `ci"` | Inside Quotes | Delete / Change inside `"..."` (works forward across lines) |
| `da"` / `ca"` | Around Quotes | Delete / Change `"..."` including outer quotes |
| `dip` / `cip` | Inside Paragraph | Delete / Change inside current paragraph |
| `sa{motion}{char}` | Surround Add | Surround target with `{char}` (e.g. `saiw"` surrounds word with `"`) |
| `sd{char}` | Surround Delete | Delete surrounding `{char}` (e.g. `sd"`, `sd)`) |
| `sr{old}{new}` | Surround Replace | Replace surrounding `{old}` with `{new}` (e.g. `sr"'`) |

---

## 6. Visual Selection

| Key | Mode | Action |
| :--- | :--- | :--- |
| `v` | Visual | Character-wise visual selection |
| `V` | Visual Line | Line-wise visual selection |
| `<C-v>` | Visual Block | Block / Column visual selection |
| `gv` | Normal | Reselect previous visual selection |

---

## 7. Search, Replace & Command Mode

| Key / Command | Action |
| :--- | :--- |
| `/{pattern}` | Search forward in document |
| `?{pattern}` | Search backward in document |
| `n` | Jump to next search match |
| `N` | Jump to previous search match |
| `:s/{old}/{new}/g` | Substitute `{old}` with `{new}` on current line / visual selection |
| `:%s/{old}/{new}/g` | Substitute `{old}` with `{new}` globally across document |
| `:w` | Save file |
| `:q` | Quit current window |
| `:wq` | Save and quit |
| `:q!` | Force quit without saving changes |
| `ZZ` | Fast save and quit |
