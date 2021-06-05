### 下载Openj9 JDK
wget http://oss.foyiwo.com/java_jdk/openj9/OpenJDK8U-jdk_x64_linux_openj9_8u252b09_openj9-0.20.0.tar.gz

### 解压
tar -zxvf OpenJDK8U-jdk_x64_linux_openj9_8u252b09_openj9-0.20.0.tar.gz

### 配置环境变量
vim /etc/profile

### 将以下配置复制进去后保存
export JAVA_HOME=/usr/local/java/jdk8u252-b09
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=${JAVA_HOME}/jre/lib/ext:${JAVA_HOME}/lib/tools.jar
export PATH=${JAVA_HOME}/bin:$PATH


### 刷新使配置生效
source /etc/profile

### 查看是否生效
java -version
