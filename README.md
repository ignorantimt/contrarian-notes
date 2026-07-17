# Contrarian Notes

非共识的认知与分析 —— 个人写作站。

- 网站：<https://ignorantimt.github.io/contrarian-notes>
- 技术栈：Jekyll + [Chirpy 主题](https://github.com/cotes2020/jekyll-theme-chirpy)，托管于 GitHub Pages，push 到 `main` 后由 GitHub Actions 自动构建发布。

## 写作流程

1. 在 `_posts/` 新建文件，命名格式：`YYYY-MM-DD-english-slug.md`
2. 文件开头写 front matter：

   ```markdown
   ---
   title: 文章标题
   date: YYYY-MM-DD HH:MM:SS +0800
   tags: [标签1, 标签2]
   description: 一句话摘要（用于 SEO 和分享卡片）
   ---
   ```

3. `git add -A && git commit -m "add post: 标题" && git push` —— 几分钟后自动上线。

草稿可放在 `_drafts/`（不会被发布）。

提交前可运行内容校验，检查 front matter、文件名和重复 slug：

```bash
bundle exec ruby tools/lint_content.rb
```

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
