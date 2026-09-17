# Push this to GitHub

The git history is already here with one commit on `main`. You just need a remote.

## 1. Create the empty repo on GitHub

Go to https://github.com/new
- Owner: **Mahlomola-Moses**
- Name: **bombi**
- Description: *One AI development setup. Any assistant.*
- Public
- **Do not** tick "Add a README", ".gitignore", or "license" — this repo already
  has them, and a pre-filled remote will cause a merge conflict on your first push.

## 2. Push

```bash
cd bombi          # this unzipped folder
git remote add origin https://github.com/Mahlomola-Moses/bombi.git
git push -u origin main
```

If you prefer SSH:
```bash
git remote add origin git@github.com:Mahlomola-Moses/bombi.git
git push -u origin main
```

## 3. Fix the author on the commit (optional)

I committed as a placeholder email. To make it yours:

```bash
git config user.name "Mahlomola Moses"
git config user.email "your-real@email.com"
git commit --amend --reset-author --no-edit
git push -f origin main        # only safe because nobody has cloned it yet
```

## 4. Check the installer works

```bash
curl -fsSL https://raw.githubusercontent.com/Mahlomola-Moses/bombi/main/install.sh | bash
```

If that 404s, the repo is private or the branch isn't `main`. Check both.
