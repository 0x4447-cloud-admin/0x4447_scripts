# AWS Cloud9 Git Credentials

When you have Cloud9, this commands will use the user that you are logged in as to allow pushing to CodeCommit

`git config --global credential.helper '!aws codecommit credential-helper $@'`
`git config --global credential.UseHttpPath true`

https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-ide-c9.html#setting-up-ide-c9-credentials