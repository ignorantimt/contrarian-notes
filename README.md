# Contrarian Notes

非共识的认知与分析 —— 个人写作站。

- 网站：<https://ignorantimt.github.io/contrarian-notes>
- 技术栈：Jekyll + [Chirpy 主题](https://github.com/cotes2020/jekyll-theme-chirpy)，托管于 GitHub Pages，push 到 `main` 后由 GitHub Actions 自动构建发布。

## 写作流程

研究过程、资料、笔记和未公开草稿保存在私有仓库 `contrarian-research`；本仓库只保存已经决定公开的文章和网站代码。

1. 在私有仓库中完成研究与草稿。
2. 决定公开后，将定稿复制到本仓库的 `_posts/`，命名格式：`YYYY-MM-DD-english-slug.md`。
3. 文件开头写 front matter：

   ```markdown
   ---
   title: 文章标题
   date: YYYY-MM-DD HH:MM:SS +0800
   tags: [标签1, 标签2]
   description: 一句话摘要（用于 SEO 和分享卡片）
   ---
   ```

4. 运行内容校验，确认没有私有研究目录被纳入版本控制。
5. 只暂存准备公开的文件，检查 `git diff --cached`，然后提交并推送；几分钟后自动上线。

提交前可运行内容校验，检查 front matter、文件名和重复 slug：

```bash
bundle exec ruby tools/lint_content.rb
```

不要在本公开仓库中使用 `_drafts/`：Jekyll 虽然默认不发布它，但 GitHub 仍会公开其中的源码和历史记录。私有研究目录已加入 `.gitignore`，CI 还会拒绝任何意外追踪的 `_drafts/`、`research/`、`notes/`、`sources/`、`ideas/` 或 `research-log/` 文件。

## 本地预览（可选）

需要 Ruby 3.2–3.4（Chirpy 7.6 暂不支持 Ruby 4；项目与 CI 固定使用 Ruby 3.4）：

```bash
bundle install
bundle exec jekyll serve
# 打开 http://localhost:4000/contrarian-notes/
```

不装本地环境也完全可以：直接 push，让 GitHub Actions 构建。

## 评论系统

站点使用 Giscus 评论系统，评论按文章路径映射到 GitHub Discussions 的 `Announcements` 分类。

## License

主题部分遵循 [MIT](LICENSE) License；文章内容版权归原作者所有。
