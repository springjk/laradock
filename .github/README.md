
# 部署文档

[TOC]

> 本教程用例为 Ubuntu Server 18.04 LTS, 其他操作系统需自行修改差异部分


## 安装 Docker

```bash
sudo apt update

# https://docs.docker.com/install/linux/docker-ce/ubuntu/

sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install docker-ce

sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## 部署 Laradock


```bash
cd {your-project}
mkdir laradock
copy 本项目中的 use-in-project 文件夹下的所有文件到 {your-project}/laradock

cd lardock
cp env-example .env

#{修改 .env 中配置值 以下为必要值示例}
#{DATA_PATH_HOST=/.laradock/data/your-project-name}
#{COMPOSE_PROJECT_NAME=your-project-name}
#{MYSQL_DATABASE=app}
#{MYSQL_PASSWORD=MySqL@DefAuLtUsEr!}
#{MYSQL_ROOT_PASSWORD=MySqL@(RoOT)UsEr%}
#{REDIS_PASSWORD=ReDiS@!DoCkEr!}
#{NGINX_HOST_HTTP_PORT=80}
#{NGINX_HOST_HTTP_PORT=443}


#其他配置需按照注释按需进行修改


sudo docker-compose up -d

bansh ./copy-default-config-from-container.sh

docker-compose down

将 docker-compose.yml 中被注释的挂载打开

docker-compose up

docker-compose exec workspace bash

composer install

php artisan migrate
php artisan db:seed
chown -R laradock:laradock public bootstrap/cache storage

composer dump-autoload
```

**以上所有配置文件需要自行按照实际情况修改配置值**
