- [x] git镜像及git ci
- [x] 通过使用镜像进行git的文档

# 镜像下载&更新

1. 在外网，带有docker客户端的电脑中**，通过运行`download_git_image.sh`文件后，生成一个名为git_image的大文件。
2. 传至内网，向gitlab对应项目提交即可，后续程序的构建，会由ci自动执行。

<!--因为为简单镜像，所以不再使用VERSION做更多的版本管理-->

# 使用命令行对git镜像进行上传下载

使用的镜像为此项目注册表镜像。

登录docker register：

```
docker login 192.168.253.131:10051
```

为便捷些，可以在中间机上将其设置环境变量：

```
export GIT_IMAGE_ADRESS=192.168.253.131:10051/mabo_group/base_application/git:latest
```

<!--export与alias的效力仅及于该次登陆操作。-->

首先需要明晰上传下载的目录，这里暂且认为为$PWD。

然后设定命名别名

```
alias git="docker run -it --rm -v ${PWD}:/git -v $HOME/.ssh:/root/.ssh $GIT_IMAGE_ADRESS"
```

剩下的操作与一般git相同。这里就不赘述了。

<!--这个是官方推荐的方式，我是感觉非常非常简单粗暴。写啥sh引导脚本啊，没有比这个更简单的了。-->

# git操作

实际操作demo：

```
# 设定上传者信息
export gitlab_username=
export gitlab_email=
# git镜像的相关定义
docker login 192.168.253.131:10051
export GIT_IMAGE_ADRESS=192.168.253.131:10051/mabo_group/base_application/git:latest
# 定义git命令
alias git="docker run -it --rm -v \${PWD}:/git -v \$HOME/.ssh:/root/.ssh \$GIT_IMAGE_ADRESS -c http.sslVerify=false -c user.name=\${gitlab_username} -c user.email=\${gitlab_email}"
# clone项目
git clone https://192.168.253.131:2443/mabo_group/base_application/git.git
# 修改了什么东西
# .....
# 上传内容
git diff
git add -A
# 创建一个名为${gitlab_username}_update的分支
git branch ${gitlab_username}_update
git commit
git push -u origin ${gitlab_username}_update
# 最后顺手把镜像删掉吧
docker rmi $GIT_IMAGE_ADRESS
```

# 使用命令行，git进行新建项目并上传

主要用于后续程序自动化，手工操作，请在网页上进行新建项目，并且clone下来后再进行传递。

> https://192.168.253.131:2443/help/gitlab-basics/create-project#push-to-create-a-new-project

```
# 前序操作与实际操作demo中的相同。
# 初始化文件
git init
# 修改了什么东西
# .....
echo "first file" >> README.md
# 上传
git diff
git add -A
git commit -m "update"
# 新建并上传一个项目
git push --set-upstream https://username:password@192.168.253.131:2443/mabo_group/deploy_application/gittest.git master
# --set-upstream	:设置当前本地分支的默认远程分支。
```

**注意这个新建的项目是私有的，需要稍后登录到网页进行修改**