# Publishing to Zejun-W / 发布到 Zejun-W

The prepared repository target is:

`https://github.com/Zejun-W/AI-Research-Writing-Skills-Hub`

## Recommended Windows method

1. Install Git and GitHub CLI.
2. Open PowerShell in this repository folder.
3. Run `gh auth login` and complete browser authorization.
4. Run `./publish_to_github.ps1`.

The script creates the public repository and pushes the current files. It does not request or store a personal access token.

## Enable the bilingual website

After the first push, open repository **Settings → Pages** and select **GitHub Actions** as the source if it is not already selected. The workflow deploys the Chinese page at the site root and English under `/en/`.
