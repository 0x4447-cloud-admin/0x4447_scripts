# Automatically create repo based on the folder name

```
dir_name=0x4447_$(basename $(pwd)) &&
aws codecommit create-repository --repository-name $dir_name &&
git init &&
git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/$dir_name &&
echo "node_modules/" >> .gitignore &&
git add . &&
git commit -m "Init" &&
git push --set-upstream origin master
```