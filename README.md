[English](README.en.md)

# 极简虎码小狼毫配置方案

- 基于虎码方案整理，提供：
  - `tigress`：虎码词库
  - `tiger`：虎码单字
- `tiger` 与 `tigress` 共享同一套简体白名单过滤逻辑
- 使用 `~` 前缀进行拼音反查
- 删除了其它快捷键和引导符，保留更简洁的输入体验
- 默认仅保留简体中文候选，并过滤异体/繁体等非目标字符
- 输入以 `;` 开头时可绕过简体过滤
- 单引号使用英文 `'` 直接上屏（可在 [symbols.yaml](symbols.yaml) 改回中文单引号 `‘’`）

## 方案说明

### `tigress`

- 面向词库输入
- 默认启用补全
- 候选与输入 UI 经过统一整理

### `tiger`

- 面向单字输入
- 输入行为与 UI 风格尽量与 `tigress` 保持一致
- 同样使用共享的简体过滤链

## 实现概览

- 共享简体白名单资源：`tigers_simp_charset`
- 简体过滤由 `OpenCC + Lua filter` 共同完成
- `tiger` / `tigress` 都显式依赖该共享资源，避免隐式耦合

## 致谢

- <https://www.tiger-code.com>
- <https://github.com/rime/weasel>
