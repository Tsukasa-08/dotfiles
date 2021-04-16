################################ -*- coding: euc-jp -*- ####
# ~ippei/.zshrc	: written by ippei@cms.mtl.kyoto-u.ac.jp
# last modified : 2004-04-28
# ���������ѡ������۲��Ǥ��	cf: man zshall
############################################################

# ���
# cd -[tab] �ǥǥ��쥯�ȥꥹ���å���ƤӽФ���
# <1-20> �ѥ�����ޥå�
#   ESC C-h �Ƕ��ڤ�ʸ���ޤǤΥХå����ڡ���
# killall���ޥ��
# ***/ �����󥯤�é��
# C-x g �磻��ɥ�����Ÿ����̤�ߤ�
#    a=aiueo
#    echo $a[1]

# �Ŀ�Ū�����Х���ɤ˻Ȥ��� C-�����Х����
# C-o, C-q, C-s
# C-t ��ʸ�����줫���ϻȤ����꤬�ɤ��ʤ��ΤǤ���ʤ�
# C-c, C-g ��������Υ��ޥ�ɤ��ä��Ƥ��ޤ��Τ򲿤Ȥ�����
# C-i �� TAB �������饯
# C-w ����
# C-v �ü�ʸ�����֤���C-v C-i �ʤ饿��ʸ����C-v C-j �ʤ����ʸ�����֤���
# C-x �ϥ��ޥ�ɤ�Ĵ�٤롣(C-x g �ߤ�����)
#### C-j or C-m �ɤ��餫���ɤ������櫓�ǤϤʤ���skkinput �� C-j ��Ȥ�

############################################################
## �Ķ��ѿ��ϼ�� ~/.zshenv �˵���
if [ -e $HOME/.zshenv ]; then
	source $HOME/.zshenv
fi

setopt print_eight_bit		# �䴰�ꥹ�Ȥ����ܸ��Ŭ��ɽ��

hosts=( localhost `hostname` )
#printers=( lw ph clw )
umask 002
cdpath=( ~ )			# cd �Υ������ѥ�

## �����ȥǥ��쥯�ȥ�˸��䤬�ʤ����Τ� cdpath ��Υǥ��쥯�ȥ꤬����ˤʤ�
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# cf. zstyle ':completion:*:path-directories' hidden true
# cf. cdpath ��Υǥ��쥯�ȥ���䴰���䤫�鳰���

## �䴰�����羮ʸ������̤��ʤ�
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#### history
HISTFILE="$HOME/.zhistory"	# ����ե�����
HISTSIZE=10000			# ��������¸����� $HISTFILE �κ��祵������
SAVEHIST=10000			# ��¸�������������

#### option, limit, bindkey
setopt	hist_ignore_all_dups	#���˥ҥ��ȥ�ˤ��륳�ޥ�ɹԤϸŤ�������
setopt	hist_reduce_blanks	#���ޥ�ɥ饤���;�פʥ��ڡ������ӽ�
setopt	share_history		#�ҥ��ȥ�ζ�ͭ

setopt	noclobber		# ��񤭥�����쥯�Ȥζػ�
setopt	nounset			# ̤����ѿ��λ��Ѥζػ�
setopt	nohup			# logout���˥Хå����饦��ɥ���֤� kill ���ʤ�
setopt	nobeep			# BEEP���Ĥ餵�ʤ�
#set -o NOTIFY	# ���Υץ��ץȤ��Ԥ����˥Хå����饦��ɥ���֤ξ����Ѳ�������

setopt	extended_glob		# ��ĥ�����
setopt	numeric_glob_sort	# ��������ͤȲ�ᤷ�ƾ��祽���Ȥǽ���
setopt	multios			# ʣ��������
setopt	auto_cd			# ��1�������ǥ��쥯�ȥ���� cd ���䴰
#setopt	auto_pushd		# ��ưŪ�� pushd �������å�������������
setopt	correct			# ���ڥ�ߥ��䴰
setopt	no_checkjobs		# exit ���˥Хå����饦��ɥ���֤��ǧ���ʤ�

limit	coredumpsize	0	# �����ե�������Ǥ��ʤ��褦�ˤ���

stty	erase	'^H'
stty	intr	'^C'
stty	susp	'^Z'

bindkey	-e			# emacs �������Х����
bindkey	'^I'	complete-word	# complete on tab, leave expansion to _expand

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

REPORTTIME=8			# CPU��8�ðʾ�Ȥä����� time ��ɽ��
TIMEFMT="\
    The name of this job.             :%J
    CPU seconds spent in user mode.   :%U
    CPU seconds spent in kernel mode. :%S
    Elapsed time in seconds.          :%E
    The  CPU percentage.              :%P"

#### completion
#_cache_hosts=(`perl -ne  'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`) # ~/.ssh/known_hosts ���鼫ưŪ�˼�������
_cache_hosts=($HOST localhost)
autoload -U compinit
compinit -u

compdef _tex platex		# platex �� .tex ��


############################################################
## �ץ��ץ�����
setopt prompt_subst		# ESC���������פ�ͭ���ˤ���

#if [ $TERM = "kterm-color" ] || [ $TERM = "xterm" ]; then
#if [ $COLORTERM = 1 ]; then
    if [ $UID = 0 ] ; then 
	PSCOLOR='01;04;31'
    else
	PSCOLOR='01;01;31'	# ��������
    fi
    RPROMPT=$'%{\e[${PSCOLOR}m%}[%~]%{\e[00m%}'	# ���ץ��ץ�
PS1=$'%{\e]2; %m:%~ \a'$'\e]1;%%: %~\a%}'$'%{\e[01;01;34m%}%n%{\e[01;01;34m%}@%{\e[01;01;31m%}%m%{\e[01;01;34m%}${WINDOW:+"[$WINDOW]"} %#%{\e[00m%} '
#fi
# 1���ܤ� $'...' �� ��\e]2;��kterm �Υ����ȥ��\a��
# 2���ܤ� $'...' �� ��\e]1;�֥�������Υ����ȥ��\a��
# 3���ܤ� $'...' ���ץ��ץ�

# emacs �Ǥ� C-q ESC, vi �Ǥ� C-v ESC �����Ϥ���
#	\e[00m 	������֤�
#	\e[01m 	����	(0�Ͼ�ά��ǽ�äݤ�)
#	\e[04m	��������饤��
#	\e[05m	blink(����)
#	\e[07m	ȿž
#	\e[3?m	ʸ�����򤫤���
#	\e[4?m	�طʿ��򤫤���
#		?= 0:��, 1:��, 2:��, 3:��, 4:��, 5:��, 6:��, 7:��

############################################################
## alias & function

#if [ -x `where dircolors` ] && [ -e $HOME/.dircolors ]; then
#    eval `dircolors $HOME/.dircolors` # ��������
#fi
if [ $ARCHI = "linux" ]; then
    alias ls="ls -F -v --group-directories-first --color=auto --show-control-char"
    # �䴰�ꥹ�Ȥ򥫥顼��
#    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
    alias ls="ls -F -v --group-directories-first"
    alias lscolor='ls -F'
fi

#alias w3m='w3m -no-mouse'
alias bell="echo '\a'"

alias vi="vim"
alias ssh="ssh -X"
alias qstatk="qstat -nu toyoura"
#alias gnuplot='rlwrap -a -c /usr/bin/gnuplot'

#alias python="/home/toyoura/program/bin/bin/python"

if [ -e ~/.zshrc_private ]; then
    source ~/.zshrc_private
fi
#source ~/.ld_library_path

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/takahashi/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/takahashi/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/takahashi/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/takahashi/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

PATH="$PATH:$HOME/bin"
