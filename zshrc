# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"

source ~/.zplug/init.zsh

zplug "romkatv/powerlevel10k", as:theme, depth:1
# 從 Github 安裝
zplug "zsh-users/zsh-history-substring-search"

# 從 on-my-zsh 安裝
zplug "plugins/git", from:oh-my-zsh

# 指定 tag
zplug "b4b4r07/enhancd", at:v1

# 排序安裝
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# 自動補全建議（依歷史指令顯示灰色建議，按右鍵補全）
zplug "zsh-users/zsh-autosuggestions"

# 安裝後觸發編譯
zplug "jhawthorn/fzy", \
as:command, \
rename-to:fzy, \
hook-build:"make && sudo make install"

if ! zplug check --verbose; then
printf "Install? [y/N]: "
if read -q; then
echo; zplug install
fi
fi

zplug load

# History 設定：跨 session 即時同步（zplug 沒有走 oh-my-zsh.sh，所以這些預設值原本沒被設定）
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY       # 其他 session 寫入的新指令，會在下個 prompt 匯入
setopt INC_APPEND_HISTORY  # 指令執行後立刻寫入檔案，不用等 session 結束
setopt APPEND_HISTORY

# Tab 補全選單優化：可用方向鍵選擇、忽略大小寫
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 修正 macOS 終端機 Option+左右鍵無法跳字的問題（顯示 ;3C / ;3D 等亂碼）
bindkey "^[[1;3C" forward-word    # Option + 右鍵：跳到下一個單字
bindkey "^[[1;3D" backward-word   # Option + 左鍵：跳到上一個單字

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
