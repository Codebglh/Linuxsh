black(){
       echo -e "\033[30m\033[01m$1 \033[0m"
}
red(){
       echo -e "\033[31m\033[01m$1 \033[0m"
}
green(){
       echo -e "\033[32m\033[01m$1 \033[0m"
}
yellow(){
       echo -e "\033[33m\033[01m$1 \033[0m"
}
blue(){
       echo -e "\033[34m\033[01m$1 \033[0m"
}
purple(){
       echo -e "\033[35m\033[01m$1 \033[0m"
}
cyan(){
       echo -e "\033[36m\033[01m$1 \033[0m"
}
white(){
       echo -e "\033[37m\033[01m$1 \033[0m"
}
jianjie(){
    echo -e "\033[30m\033[01m$1\033[0m" "\033[34m\033[01m$2 \033[0m"
}
xuanzhe(){
    echo -e "\033[30m\033[01m$1\033[0m" "\033[35m\033[01m$2 \033[0m"
}

choice(){
    cyan " -----------------------------------------------------------------------"
    xuanzhe " 1." " 检查环境"
    xuanzhe " 2." " 安装nodejs"
    xuanzhe " 3." " 卸载nodejs"
    xuanzhe " 4." " 安装nodejs相关包管理常见依赖nrm、encoryp-js、http-server等"
    xuanzhe " 5." " 创建nodejs软链接"
    xuanzhe " 6." " 安装zsh"
    xuanzhe " 7." " 安装ohmyzsh"
    xuanzhe " 0." " 退出脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           check "wget"
	;;

        2 )
            inodejs
    ;;

        3 )
            unodejs

    ;;  4 )
            inpm

    ;;  5 )
            crlink

    ;;  6 )
            inzsh

    ;;  7 )
            inohmyzsh
    ;;
        0 )
            rm -f /root/box.sh
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            choice
        ;;
    esac
}
function check(){
    cyan "检查wget是否安装"
    rpm -qa|grep $1 &> /dev/null
    if [ $? -eq 0 ]; then
        green "$1 已经安装"
    else
        red "$1 未安装"
        black "准备安装wget"
        sudo yum install wget
        sudo  mv /etc/yum.repos.d/CentOS-Base.repo  /etc/yum.repos.d/CentOS-Base.repo.bak
        wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
        green "$1 已安装"
    fi
    choice
}
function inpm(){
    black "修改npm源"
    npm config set registry https://registry.npm.taobao.org/
    black "下载nrm npm源管理器、crypto-js解密、下载cnpm、下载express"
    npm install nrm crypto-js cnpm express -g
    black "添加软连接"
    sudo ln -sf /usr/lib/nodejs/bin/* /usr/local/bin/
    nrm add wangyi  https://mirrors.163.com/npm/
    nrm add aliyun  https://npm.aliyun.com/
    nrm add hw      https://mirrors.huaweicloud.com/repository/npm/
    nrm add tb      https://npm.taobao.org/
    nrm use hw
    choice
}
function crlink(){
    sudo ln -sf /usr/lib/nodejs/bin/* /usr/local/bin/
    choice
}
function inodejs(){
    black "安装node.js"
    wget -O /root/node-v16.20.2-linux-x64.tar.xz https://nodejs.org/download/release/v16.20.2/node-v16.20.2-linux-x64.tar.xz
    yum install xz-libs.i686
    sudo xz -d  node-v16.20.2-linux-x64.tar.xz
    sudo tar -xvf node-v16.20.2-linux-x64.tar  &> /dev/null
    rm -f node-v16.20.2-linux-x64.tar
    sudo mv node-v16.20.2-linux-x64 /usr/lib/nodejs
    sudo ln -sf /usr/lib/nodejs/bin/* /usr/local/bin/
    node -v &> /dev/null
    if [ $? -eq 0 ]; then
        green "node 已经安装"
    else
        red "node环境变量未设置成功"
    fi
    npm -v &> /dev/null
    if [ $? -eq 0 ]; then
        green "npm 已经安装"
    else
        red "npm环境变量未设置成功"
    fi
    choice
}
function unodejs(){
    sudo rm -rf /usr/lib/nodejs /usr/local/bin/*
    node -v &> /dev/null
     if [  $? -eq 0 ]; then
        red "nodejs 未卸载成功"
    else
        green "nodejs 卸载成功"
    fi
    choice
}
function inzsh(){
    wget https://jaist.dl.sourceforge.net/project/zsh/zsh/5.9/zsh-5.9.tar.xz 
    tar xvf zsh-5.9.tar.xz    
    yum install gcc perl-ExtUtils-MakeMaker
    yum install ncurses-devel
    cd zsh-5.9
    ./configure
    make && make install
    blue "在最后一行加上：/usr/local/bin/zsh"
    echo
    read -p "复制相关数据输入y进入配置" bg
    case $bg  in
        y )
           vi /etc/shells
	    ;;
        * )
            
            red "未成功配置 !"
            
        ;;
    esac
    chsh -s /usr/local/bin/zsh
    zsh --version  &> /dev/null
     if [  $? -eq 0 ]; then
        green "zsh安装成功"
    else
        red "zsh安装失败"
    fi
    choice
}
function inohmyzsh(){
    #安装oh-my-zsh
    sh -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    #2安装powerlevel10k主题
    git clone  https://ghproxy.com/https://github.com/romkatv/powerlevel10k.git   ./.oh-my-zsh/themes
    
    blue "修改 ZSH_THEME=\"powerlevel10k/powerlevel10k\""
    #安装语法高亮插件
    git clone https://ghproxy.com/https://github.com/zsh-users/zsh-syntax-highlighting.git  ./.oh-my-zsh/custom/plugins/

    #安装自动补全插件
    git clone https://ghproxy.com/https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/


    blue "修改 plugins=(
     git
     zsh-syntax-highlighting
     zsh-autosuggestions
)"
    blue "HIST_STAMPS=\"yyyy-mm-dd\" 设置时间为年月日"
    vi .zshrc
    source .zshrc
    p10k configure 
}
function start_menu(){
    jianjie " FROM:" "https://github.com/ "
    jianjie " USE:" "wget -O box.sh https://cdn.jsdelivr.net/gh/Codebglh/command@0.0.3/Linux/box.sh && chmod +x box.sh && clear && ./box.sh "
    purple   "\t\t\tBGcode  命令盒子\t\t\t "
    choice
}
start_menu "first"