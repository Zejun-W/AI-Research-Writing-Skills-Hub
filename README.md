# AI Research Writing Skills Hub

[简体中文](README.md) | [English](README_EN.md) | [在线双语目录](https://zejun-w.github.io/AI-Research-Writing-Skills-Hub/)

> 一个面向科研人员的双语开源导航与实践仓库：系统总结 AI 论文写作 Prompt、Agent Skill、科研方法论与自动科研系统，并提供可直接安装和改造的原创统一 Skills。

## 这个仓库解决什么问题

科研写作相关项目很多，但它们的定位并不相同：有的是提示词合集，有的是章节写作 Skill，有的是科研工具箱，还有的是从想法到论文的自动科研系统。只按 Stars 排序会把这些项目混在一起，导致选择困难。

本仓库提供四层内容：

1. **持续更新的仓库排行**：GitHub Actions 每日同步 Stars、Forks、Issues、许可证与更新时间。
2. **双语深度总结**：说明每个项目真正适合谁、优势、局限、部署成本和风险。
3. **原创统一 Skills**：不复制上游代码，提炼为可供 Codex、Claude Code 和兼容 Agent 使用的论文工作流。
4. **可复制 Prompt 库**：覆盖论文体检、引言、相关工作、方法一致性、实验分析、审稿与中英转换。

## 推荐结论

- **Codex 主工作流**：`academic-research-skills-codex` + 本仓库 `research-writing-orchestrator`。
- **计算机论文章节写作**：`Research-Paper-Writing-Skills` + `paper-writing-skill`。
- **中文提示词素材**：`awesome-ai-research-writing`。
- **实验与论文联动**：`AI-Research-SKILLs`；需要大量科学工具时再使用 `scientific-agent-skills`。
- **接近投稿时的质量控制**：`academic-writing-agents` + 本仓库 `paper-qc-reviewer`。
- **自动科研系统**：主要用于研究、实验和参考，不应把自动生成结果未经人工验证直接投稿。

## 按 Stars 排序

<!-- REPO_TABLE_START -->
> Stars、Forks、Issues 和更新时间由 GitHub Actions 每日同步。

| 排名 | 仓库 | Stars | Forks | 类型 | 最适合 | 综合建议 |
|---:|---|---:|---:|---|---|---:|
| 1 | [binary-husky/gpt_academic](https://github.com/binary-husky/gpt_academic) | 71,034 | 8,354 | research-assistant | 需要图形界面、中文生态和大量现成学术插件的研究者。 | 4.7/5 |
| 2 | [Imbad0202/academic-research-skills](https://github.com/Imbad0202/academic-research-skills) | 36,137 | 2,954 | writing-workflow | 需要完整论文生命周期管理、希望降低幻觉和引用风险的研究者。 | 5.0/5 |
| 3 | [Leey21/awesome-ai-research-writing](https://github.com/Leey21/awesome-ai-research-writing) | 30,432 | 2,311 | prompt-collection | 希望直接复制提示词并快速改善论文表达的中文用户。 | 4.9/5 |
| 4 | [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) | 30,087 | 3,041 | scientific-skills | 需要让编码Agent执行数据分析、科学计算和多步骤科研任务的团队。 | 4.5/5 |
| 5 | [SakanaAI/AI-Scientist](https://github.com/SakanaAI/AI-Scientist) | 14,142 | 2,010 | autonomous-research | 研究自动科研系统、复现实验流水线或进行Agent研究的用户。 | 4.2/5 |
| 6 | [aiming-lab/AutoResearchClaw](https://github.com/aiming-lab/AutoResearchClaw) | 13,689 | 1,600 | autonomous-research | 希望研究或搭建长流程自动科研系统，并保留人机协作检查点的用户。 | 4.4/5 |
| 7 | [pengsida/learning_research](https://github.com/pengsida/learning_research) | 13,015 | 661 | research-methodology | 计算机视觉、机器学习方向的研究生，以及希望构建长期科研习惯的用户。 | 4.8/5 |
| 8 | [wanshuiyin/Auto-claude-code-research-in-sleep](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | 12,973 | 1,177 | autonomous-research | 希望把科研任务拆成持续循环、并用Agent推动进度的研究者。 | 4.4/5 |
| 9 | [Orchestra-Research/AI-Research-SKILLs](https://github.com/Orchestra-Research/AI-Research-SKILLs) | 10,357 | 773 | ai-research-engineering | 需要让Agent同时理解AI实验工程与论文写作的计算机研究者。 | 4.8/5 |
| 10 | [SakanaAI/AI-Scientist-v2](https://github.com/SakanaAI/AI-Scientist-v2) | 6,761 | 927 | autonomous-research | 研究自动科学发现、Agent搜索策略与端到端论文生成的用户。 | 4.1/5 |
| 11 | [HKUDS/AI-Researcher](https://github.com/HKUDS/AI-Researcher) | 5,521 | 693 | autonomous-research | 希望研究多Agent科研系统或从种子论文扩展研究方向的用户。 | 4.0/5 |
| 12 | [Imbad0202/academic-research-skills-codex](https://github.com/Imbad0202/academic-research-skills-codex) | 5,412 | 283 | writing-workflow | 主要使用OpenAI Codex完成论文规划、审稿、修改与质量检查的研究者。 | 5.0/5 |
| 13 | [ahmetbersoz/chatgpt-prompts-for-academic-writing](https://github.com/ahmetbersoz/chatgpt-prompts-for-academic-writing) | 4,796 | 386 | prompt-collection | 刚开始使用LLM辅助学术写作、希望快速获得任务模板的用户。 | 4.2/5 |
| 14 | [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills) | 4,690 | 240 | writing-skill | 需要小而精、容易定制的计算机论文写作Skill用户。 | 4.9/5 |
| 15 | [xuhangc/ChatGPT-Academic-Prompt](https://github.com/xuhangc/ChatGPT-Academic-Prompt) | 785 | 84 | prompt-collection | 面向AI顶会写作、需要具体表达模板的研究者。 | 4.1/5 |
| 16 | [dixiyao/LLM-Academic-Writing](https://github.com/dixiyao/LLM-Academic-Writing) | 139 | 4 | review-workspace | 需要轻量论文审查模板和工作区参考的用户。 | 3.5/5 |
| 17 | [Epsilon617/Codex-Academic-Skills](https://github.com/Epsilon617/Codex-Academic-Skills) | 138 | 4 | awesome-list | 明确以Codex为主、希望持续扩展技能库的用户。 | 3.9/5 |
| 18 | [andrehuang/academic-writing-agents](https://github.com/andrehuang/academic-writing-agents) | 129 | 15 | review-agents | 论文接近定稿、希望进行分角色系统审查的用户。 | 4.3/5 |
| 19 | [BevalZ/awesome-prompt-for-academic](https://github.com/BevalZ/awesome-prompt-for-academic) | 99 | 6 | prompt-collection | 需要跨学科、跨语言提示词检索的用户。 | 3.8/5 |
| 20 | [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill) | 88 | 5 | writing-skill | 重视论文论证结构、压缩表达和系统编辑流程的研究者。 | 4.7/5 |
<!-- REPO_TABLE_END -->

## 仓库结构

```text
.
├── README.md / README_EN.md       # 中英文主页
├── index.html / en/index.html     # 双语 GitHub Pages
├── data/repositories.json         # 结构化仓库资料
├── docs/                          # 选型、工作流、完整总结
├── prompts/zh-CN + prompts/en-US  # 双语可复制提示词
├── skills/                        # 原创统一 Agent Skills
├── scripts/update_repositories.py # 自动同步 GitHub 元数据
└── .github/workflows/             # 每日排行与 Pages 部署
```

## 直接使用统一 Skill

将需要的 Skill 文件夹复制到 Agent 的项目级 Skills 目录。不同客户端目录可能不同，应以各自官方文档为准。

```bash
# 示例：复制到当前项目的 skills 目录
mkdir -p .agent/skills
cp -r skills/research-writing-orchestrator .agent/skills/
cp -r skills/evidence-and-citation-auditor .agent/skills/
cp -r skills/paper-qc-reviewer .agent/skills/
```

建议只加载当前任务需要的 1–3 个 Skills，避免上下文拥挤和规则冲突。

## Windows 一键发布

Windows 用户可双击 `deploy.bat`，或在 PowerShell 中执行：

```powershell
.\publish_to_github.ps1
```

## 质量与学术诚信原则

- AI 只能辅助研究者组织、检查和表达，不能替代作者对事实、实验和结论负责。
- 不允许编造论文、DOI、作者、数据、实验或审稿意见。
- 所有引用必须回到原文核验；搜索摘要不能替代阅读全文。
- 修改论文时必须区分“原文事实”“推断”“建议”和“待验证内容”。
- 自动科研系统产生的代码、数据、图表和结论必须重新运行并保存可追溯记录。

## 许可证与上游项目

本仓库的原创总结、网站、脚本和 Skills 使用 MIT License。上游仓库的代码和文本仍受各自许可证约束。本项目默认只链接和总结上游内容，不重新分发其源代码。详见 [NOTICE.md](NOTICE.md)。

## 贡献

欢迎通过 Issue 或 Pull Request 新增仓库、修正总结、补充中英文内容。请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)。
