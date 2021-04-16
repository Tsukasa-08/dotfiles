################################ -*- coding: euc-jp -*- ####
# ~ippei/.zshrc	: written by ippei@cms.mtl.kyoto-u.ac.jp
# last modified : 2004-04-28
# 修正、改変、再配布何でも可	cf: man zshall
############################################################

# メモ
# cd -[tab] でディレクトリスタックを呼び出せる
# <1-20> パターンマッチ
#   ESC C-h で区切り文字までのバックスペース
# killallコマンド
# ***/ シムリンクを辿る
# C-x g ワイルドカード展開結果をみる
#    a=aiueo
#    echo $a[1]

# 個人的キーバインドに使える C-キーバインド
# C-o, C-q, C-s
# C-t の文字入れかえは使い勝手が良くないのでいらない
# C-c, C-g は入力中のコマンドが消えてしまうのを何とかする
# C-i は TAB の方がラク
# C-w 改良
# C-v 特殊文字を置く。C-v C-i ならタブ文字、C-v C-j なら改行文字を置ける
# C-x 系コマンドを調べる。(C-x g みたいな)
#### C-j or C-m どちらかで良い。→わけではない。skkinput で C-j を使う

############################################################
## 環境変数は主に ~/.zshenv に記述
if [ -e $HOME/.zshenv ]; then
	source $HOME/.zshenv
fi

setopt print_eight_bit		# 補完リストの日本語を適正表示

hosts=( localhost `hostname` )
#printers=( lw ph clw )
umask 002
cdpath=( ~ )			# cd のサーチパス

## カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリが候補になる
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# cf. zstyle ':completion:*:path-directories' hidden true
# cf. cdpath 上のディレクトリは補完候補から外れる

## 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#### history
HISTFILE="$HOME/.zhistory"	# 履歴ファイル
HISTSIZE=10000			# メモリ上に保存される $HISTFILE の最大サイズ？
SAVEHIST=10000			# 保存される最大履歴数

#### option, limit, bindkey
setopt	hist_ignore_all_dups	#既にヒストリにあるコマンド行は古い方を削除
setopt	hist_reduce_blanks	#コマンドラインの余計なスペースを排除
setopt	share_history		#ヒストリの共有

setopt	noclobber		# 上書きリダイレクトの禁止
setopt	nounset			# 未定義変数の使用の禁止
setopt	nohup			# logout時にバックグラウンドジョブを kill しない
setopt	nobeep			# BEEPを鳴らさない
#set -o NOTIFY	# 次のプロンプトを待たずにバックグラウンドジョブの状態変化を通知

setopt	extended_glob		# 拡張グロブ
setopt	numeric_glob_sort	# 数字を数値と解釈して昇順ソートで出力
setopt	multios			# 複数入出力
setopt	auto_cd			# 第1引数がディレクトリだと cd を補完
#setopt	auto_pushd		# 自動的に pushd ←スタックが増えすぎる
setopt	correct			# スペルミス補完
setopt	no_checkjobs		# exit 時にバックグラウンドジョブを確認しない

limit	coredumpsize	0	# コアファイルを吐かないようにする

stty	erase	'^H'
stty	intr	'^C'
stty	susp	'^Z'

bindkey	-e			# emacs 風キーバインド
bindkey	'^I'	complete-word	# complete on tab, leave expansion to _expand

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

REPORTTIME=8			# CPUを8秒以上使った時は time を表示
TIMEFMT="\
    The name of this job.             :%J
    CPU seconds spent in user mode.   :%U
    CPU seconds spent in kernel mode. :%S
    Elapsed time in seconds.          :%E
    The  CPU percentage.              :%P"

#### completion
#_cache_hosts=(`perl -ne  'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`) # ~/.ssh/known_hosts から自動的に取得する
_cache_hosts=($HOST localhost)
autoload -U compinit
compinit -u

compdef _tex platex		# platex に .tex を


############################################################
## プロンプト設定
setopt prompt_subst		# ESCエスケープを有効にする

#if [ $TERM = "kterm-color" ] || [ $TERM = "xterm" ]; then
#if [ $COLORTERM = 1 ]; then
    if [ $UID = 0 ] ; then 
	PSCOLOR='01;04;31'
    else
	PSCOLOR='01;01;31'	# 下線、青
    fi
    RPROMPT=$'%{\e[${PSCOLOR}m%}[%~]%{\e[00m%}'	# 右プロンプト
PS1=$'%{\e]2; %m:%~ \a'$'\e]1;%%: %~\a%}'$'%{\e[01;01;34m%}%n%{\e[01;01;34m%}@%{\e[01;01;31m%}%m%{\e[01;01;34m%}${WINDOW:+"[$WINDOW]"} %#%{\e[00m%} '
#fi
# 1個目の $'...' は 「\e]2;「kterm のタイトル」\a」
# 2個目の $'...' は 「\e]1;「アイコンのタイトル」\a」
# 3個目の $'...' がプロンプト

# emacs では C-q ESC, vi では C-v ESC で入力する
#	\e[00m 	初期状態へ
#	\e[01m 	太字	(0は省略可能っぽい)
#	\e[04m	アンダーライン
#	\e[05m	blink(太字)
#	\e[07m	反転
#	\e[3?m	文字色をかえる
#	\e[4?m	背景色をかえる
#		?= 0:黒, 1:赤, 2:緑, 3:黄, 4:青, 5:紫, 6:空, 7:白

############################################################
## alias & function

#if [ -x `where dircolors` ] && [ -e $HOME/.dircolors ]; then
#    eval `dircolors $HOME/.dircolors` # 色の設定
#fi
if [ $ARCHI = "linux" ]; then
    alias ls="ls -F -v --group-directories-first --color=auto --show-control-char"
    # 補完リストをカラー化
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
