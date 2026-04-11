# Minimalist Weasel Configuration for Tiger Code

This configuration is based on the bare-bones version of the Tiger Code schema and features the following:

- Offers two input schemes: `tiger` (single characters) and `tigress` (phrases).
- By default, only Simplified Chinese candidates are shown; non-target characters such as variant or Traditional Chinese characters are filtered out. The `tigers_simp_charset` whitelist is implemented using OpenCC and Lua.
- Uses only `Control + F8` to toggle input schemes and full/half-width modes.
- Includes modifications for certain symbols when in full-width mode (see `symbols.yaml`).
- Enables pinyin reverse lookup using the `~` prefix.
- Four-key auto-commit is enabled (note: some phrases in `tigress` cannot be auto-committed).
- Added `tigress_simp_ci.dict` to `tiger`
- Most hotkeys and guide characters have been removed to ensure a more streamlined input experience.

# Acknowledgements

- <https://www.tiger-code.com>
- <https://github.com/rime/weasel>
