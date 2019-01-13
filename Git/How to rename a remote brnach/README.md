# How to rename a remote branch

1. Rename branch locally
1. Delete the old branch
1. Push the new branch, set local branch to track the new remote

```
git branch -m dev development
git push origin :dev
git push --set-upstream origin development
```