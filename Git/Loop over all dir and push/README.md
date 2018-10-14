# Loop over all dir and push

```
for d in */; do cd $d; (git add . && git commit -m "update the package.json"); cd ..; done

for d in */; do cd $d; (git push); cd ..; done
```