# AI 技能目录

本目录用于存放项目专用的 AI 技能（Skills），辅助 NSFC 标书写作和 LaTeX 编译。

## 技能开发规范

每个技能应包含以下文件：

```
skills/
└── skill-name/
    ├── SKILL.md       # 技能功能文档
    ├── config.yaml    # 技能配置（包含版本信息）
    └── scripts/       # 可选脚本
```

### config.yaml 模板

```yaml
skill_info:
  name: skill-name
  version: 1.0.0
  description: 技能功能描述
  category: writing  # writing|development|normal
```

## 当前技能列表

暂无项目专用技能。可参考 [ChineseResearchLaTeX](https://github.com/huangwb8/ChineseResearchLaTeX) 的技能实现。

## 推荐外部技能

以下技能来自 ChineseResearchLaTeX 项目，可按需引用：

| 技能 | 功能 | 适用场景 |
|------|------|----------|
| `nsfc-justification-writer` | 立项依据写作 | 撰写/重构立项依据 |
| `nsfc-research-content-writer` | 研究内容写作 | 撰写研究内容/创新点/计划 |
| `nsfc-research-foundation-writer` | 研究基础写作 | 撰写研究基础/工作条件 |
| `nsfc-abstract` | 摘要生成 | 生成中英文摘要 |
| `systematic-literature-review` | 系统综述 | 文献调研 |

## 技能调用

在 Claude Code 中使用自然语言描述即可触发技能：

```
请使用 nsfc-justification-writer 帮我优化立项依据部分
```
