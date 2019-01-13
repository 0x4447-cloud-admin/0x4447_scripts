# How to recover deleted files in S3 with Versioning enabled

When you have S# versioning enabled there is no UI in the AWS Dashboard that can help you recover all the files at once – you can recover individual files. To do so the command bellow is going to get all the object in a bucket, filter those with a DELETED tag, and create a Bash script which once executed will remove the marker, thus recovering the file in S3.

```
AWS_ACCESS_KEY_ID=KEY AWS_SECRET_ACCESS_KEY=SECRET aws s3api list-object-versions --bucket BUCKET_NAME --output text | grep -E "^DELETEMARKERS" | awk '{FS = "[\t]+"; print "aws s3api delete-object --bucket BUCKET_NAME --key \42"$3"\42 --version-id "$5";"}' >> undelete_script.sh
```



