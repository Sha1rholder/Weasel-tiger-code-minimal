[English](README.en.md)

# 极简虎码小狼毫配置方案

本方案基于虎码秃版方案整理。具有以下特性：

- 提供`tiger`（虎码单字）和`tigress`（虎码词库）两种输入方案
- 默认仅保留简体中文候选，并过滤异体/繁体等非目标字符。白名单`tigers_simp_charset`由OpenCC和Lua实现
- 仅使用`Control + F8`切换输入方案和全/半角
- 全角输入时对部分符号做了修改，见`symbols.yaml`
- 使用`~`前缀进行拼音反查
- 已开启四码上屏（`tigress`下有部分词无法直接上屏）
- 删除了多数快捷键和引导符，保留更简洁的输入体验

# 致谢

- <https://www.tiger-code.com>
- <https://github.com/rime/weasel>
