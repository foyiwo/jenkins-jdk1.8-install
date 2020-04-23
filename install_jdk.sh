#!/bin/bash

# jdk install
# 请将下载的jdk-xxx-linux-xxx.tar.gz包与此脚本放置到同一目录
# 授予此脚本可执行权限(chmod +x install_jdk.sh)
# 在终端执行此脚本开始安装(./文件名)
# 注意：不可有多个版本的jdk包！
#      为了使配置的环境变量生效，安装完成后你应该重新登陆。

echo "Please select you want to install the JDK version?"

jdk_version="JDK1.8"

jvmpath=/usr/local/java/

# 不存在
if [ ! -d "$jvmpath" ]; then
    echo "正在创建$jvmpath目录"
    sudo mkdir $jvmpath
    echo "目录$jvmpath创建成功"
fi

jdkfile=$(ls | grep jdk-*-linux-*.gz)
jdkdirname=""

if [ "$jdk_version" = "JDK1.7" ]; then
    jdkdirname="jdk1.7.0_75"
else
    jdkdirname="jdk1.8.0_20"
fi

cd $jvmpath

os_version=`uname -a`
echo $os_version
architecture="64"
echo "$os_version" | grep -q "$architecture"
if [ $? -eq 0 ]
then
    echo "您正在使用64位操作系统，为您选择64位JDK"
    # 不存在即去外网下载jdk文件
    if [ ! -f "$jdkfile" ]; then
        if [ "$jdk_version" = "JDK1.7" ]; then
            wget http://oss.foyiwo.com/java_jdk/1.8/jdk-8u20-linux-x64.tar.gz
        else
            wget http://oss.foyiwo.com/java_jdk/1.8/jdk-8u20-linux-x64.tar.gz
        fi
    fi  
    #sudo chown -R jiangxin:jiangxin /usr/lib/jvm/jdk1.7.0_75
else
    echo "您正在使用32位操作系统，为您选择32位JDK"
    # 不存在即去外网下载jdk文件
    if [ ! -f "$jdkfile" ]; then
        if [ "$jdk_version" = "JDK1.7" ]; then
            wget http://oss.foyiwo.com/java_jdk/1.8/jdk-8u20-linux-x64.tar.gz
        else
            wget http://oss.foyiwo.com/java_jdk/1.8/jdk-8u20-linux-x64.tar.gz
        fi
    fi
fi

jdkfile=$(ls | grep jdk-*-linux-*.gz)

if [ -f "$jdkfile" ]; then

    sudo tar -zxvf $jdkfile -C /usr/local/java/

    echo "安装JDK成功"

    echo "配置环境变量"
    # touch environment  
    # echo "PATH=\"$PATH:/usr/lib/jvm/$jdkdirname/bin\"" >> environment
    # echo "JAVA_HOME=/usr/lib/jvm/$jdkdirname" >> environment
    # echo "CLASSPATH=.:%JAVA_HOME%/lib/dt.jar:%JAVA_HOME%/lib/tools.jar" >> environment
    # sudo mv /etc/environment /etc/environment.backup.java
    # sudo mv environment /etc
    # source /etc/environment

    mv ~/.bashrc ~/.bashrc.backup.java
    cat ~/.bashrc.backup.java >> ~/.bashrc
    echo "PATH=\"$PATH:$jvmpath/$jdkdirname/bin\"" >> ~/.bashrc
    echo "JAVA_HOME=$jvmpath/$jdkdirname" >> ~/.bashrc
    echo "CLASSPATH=.:%JAVA_HOME%/lib/dt.jar:%JAVA_HOME%/lib/tools.jar" >> ~/.bashrc
    source ~/.bashrc
    echo "配置环境成功"

    # 如果有多个java版本需要进行以下配置（包括openjdk）
    echo "设置默认jdk"
    sudo update-alternatives --install /usr/bin/java java $jvmpath/$jdkdirname/bin/java 300
    sudo update-alternatives --install /usr/bin/javac javac $jvmpath/$jdkdirname/bin/javac 300
    sudo update-alternatives --config java
    # echo "设置默认jdk成功"

    echo "测试是否安装成功"
    java -version
    echo "安装成功"

fi