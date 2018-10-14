# How to create an empty branch

```
git checkout --orphan assets

This will create a new branch with no parents. Then, you can clear the working directory with:

git rm --cached -r .