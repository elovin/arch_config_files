# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-syntax-highlighting
  git
  zsh-autosuggestions
  history-substring-search
)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh



# custom

bindkey '^[[H'       beginning-of-line
bindkey '^[[F'       end-of-line

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

setopt COMPLETE_ALIASES

alias min-power="sudo /usr/bin/cpupower frequency-set -g powersave"
alias max-power="sudo /usr/bin/cpupower frequency-set -g performance"

alias uu="yay && flatpak update"
alias unlockme="faillock --reset --user ${USER}"

alias steam-mesa-git="FLATPAK_GL_DRIVERS=mesa-git flatpak run com.valvesoftware.Steam"

alias update-aurora-services="echo 'accept on your phone if necessary!' && sudo adb root shell && sudo adb shell mount -o remount,rw / && sudo adb push ~/Downloads/AuroraServices_v1.1.1.apk /system/priv-app && sudo adb push ~/Downloads/permissions_com.aurora.services.xml /system/etc/permissions/"

export VAGRANT_DEFAULT_PROVIDER=libvirt

#alias update-dxvk="(cd ~/Documents/dxvk-tools && ./updxvk build && ./upvkd3d-proton build && ./updxvk lutris && ./upvkd3d-proton lutris)"

alias cpu-mhz='watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'

# https://dev.to/meleu/how-to-join-array-elements-in-a-bash-script-303a
join_by() { local IFS="${1}"; shift; echo "${*}"; }

rm() {
	local invalidFlagPattern='^-[fiI]+'
	local args=()
	local fileOrDirToRemove
	local command

	for param in "${@}"
	do
		if [[ $param != -* ]]
		then
			fileOrDirToRemove="${param}"
			continue
		fi

		if [[ $param =~ ${invalidFlagPattern} ]] || [[ $param == "--force" ]]
		then
			continue
		fi

		if [[ $param == -*f* ]]
		then
			param="$(echo ${param//f})"
		fi

		if [[ $param == -*i* ]]
		then
			param="$(echo ${param//i})"
		fi

		if [[ $param == -*I* ]]
		then
			param="$(echo ${param//I})"
		fi

		args+=($param)
	done

	
	if [[ -d ${fileOrDirToRemove}  ]]
	then
		command="/usr/bin/rm -I $(join_by ' ' "${args}") ${fileOrDirToRemove}"
	elif [[ -f ${fileOrDirToRemove} ]]
	then
		command="/usr/bin/rm -i $(join_by ' ' "${args}") ${fileOrDirToRemove}"
	else
	    	echo "${fileOrDirToRemove} no valid file or directory"
		return 1
	fi

	zsh -c "${command}"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


