# Add Repo to Project

```
git init &&
git remote add origin https://github.com/PATH.git &&
echo "node_modules/" >> .gitignore &&
git add . &&
git commit -m "Init" &&
git push --set-upstream origin master --force
```