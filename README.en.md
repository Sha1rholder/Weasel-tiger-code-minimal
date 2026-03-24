# Minimal Tiger Code Weasel Configuration

[中文说明](README.md)

This repository provides a minimalist Weasel/Rime setup for both:

- `tigress`: Tiger Code word input
- `tiger`: Tiger Code single-character input

## Features

- Based on the Tiger Code Weasel setup, simplified into a minimal configuration
- Supports both `tigress` and `tiger`
- Use `~` for Pinyin reverse lookup
- Removes most extra shortcuts and guide symbols
- Uses a Simplified Chinese-only candidate pipeline
- Filters out traditional/variant forms in normal input
- Keeps `;`-prefixed bypass behavior for special input
- Single quote outputs `'` directly  
  (you can change it back to Chinese single quotes `‘’` in [symbols.yaml](symbols.yaml))

## Schemas

- `tigress`: word input, minimalist style
- `tiger`: single-character input, aligned with `tigress` behavior and UI

Both schemas share the same simplified-character whitelist and filtering logic.

## Notes

- If you change schema or dictionary files, redeploy Rime/Weasel to rebuild generated files.
- The shared simplified whitelist is an internal helper resource and is not meant for direct use.

## Acknowledgments

- <https://www.tiger-code.com>
- <https://github.com/rime/weasel>
