#!/bin/bash
#author :bgcode
#warefare : https://github.com/Codebglh/command
#颜色定义
function black(){
       echo -e "\033[30m\033[01m$1 \033[0m"  #黑色
}
function red(){
       echo -e "\033[31m\033[01m$1 \033[0m"  #红色
}
function green(){
       echo -e "\033[32m\033[01m$1 \033[0m"  #绿色
}
function yellow(){
       echo -e "\033[33m\033[01m$1 \033[0m"  #黄色
}
function blue(){
       echo -e "\033[34m\033[01m$1 \033[0m"  #蓝色
}
function purple(){
       echo -e "\033[35m\033[01m$1 \033[0m"  #紫色
}
function cyan(){
       echo -e "\033[36m\033[01m$1 \033[0m"  #请色
}
function white(){
       echo -e "\033[37m\033[01m$1 \033[0m"  #白色
}
function xuanzhe(){
    echo -e "\033[30m\033[01m$1\033[0m" "\033[35m\033[01m$2 \033[0m"
}
function jianjie(){
    echo -e "\033[30m\033[01m$1\033[0m" "\033[34m\033[01m$2 \033[0m"
}
#安装homebrew
function inhomebrew(){
    /bin/zsh -c "$(curl -fsSL  https://cdn.jsdelivr.net/gh/Codebglh/command@0.0.3/Mac/Homebrew.sh)"
    choice
}
#shell美化
function ohmyzsh(){
    #安装oh-my-zsh
    sh -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    #2安装powerlevel10k主题
    git clone  https://ghproxy.com/https://github.com/romkatv/powerlevel10k.git   ./.oh-my-zsh/themes
    #安装语法高亮插件
    git clone https://ghproxy.com/https://github.com/zsh-users/zsh-syntax-highlighting.git  ./.oh-my-zsh/custom/plugins/
    #安装自动补全插件
    git clone https://ghproxy.com/https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/
    #编辑zsh配置文件
    blue "修改 ZSH_THEME=\"powerlevel10k/powerlevel10k\""
    blue "修改 plugins=(
                    git
                    zsh-syntax-highlighting
                    zsh-autosuggestions
            )"
    blue "HIST_STAMPS="yyyy-mm-dd" 设置时间为年月日"
    blue "vi .zshrc"
    blue "source .zshrc"
    blue "p10k configure"
    choice
}
function test(){
    choice
}
function choice(){
    cyan " -----------------------------------------------------------------------"
    xuanzhe " 1." " 安装homebrew"
    xuanzhe " 2." " 安装ohmyzsh"
    xuanzhe " 3." " test"
    xuanzhe " 0." " 退出脚本"
    echo
    read -p "请输入一个数字：" number
    case $number  in
        1 )
           inhomebrew
	    ;;
        2 )
           ohmyzsh
	    ;;
        3 )
           test
	    ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            choice
        ;;
    esac
}
function main(){
    jianjie " FROM:" "https://github.com/ "
    jianjie " USE:" "/bin/zsh -c \"\$(curl -fsSL  https://cdn.jsdelivr.net/gh/Codebglh/command@0.0.3/Mac/main.sh)\""
    purple   "\t\t\tBGcode  命令盒子\t\t\t "
    choice 
}
main