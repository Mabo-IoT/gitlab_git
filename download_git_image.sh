#！/bin/bash
tag='latest '
image='alpine/git'
name='git_image'
# download image
docker pull $image:$tag
docker save -o $name $image:$tag