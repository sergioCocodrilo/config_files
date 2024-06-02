# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sergio/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# colorize zsh
alias ls='ls --color=auto'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

autoload -U colors && colors
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%1~%{$reset_color%} %% "


# https://github.com/moisestohias/LinuxToolsConf/blob/master/wit_wii_gamecube_convert.md
#
# ░█▄░█░█░█▄░█░▀█▀▒██▀░█▄░█░█▀▄░▄▀▄
# ░█▒▀█░█░█▒▀█░▒█▒░█▄▄░█▒▀█▒█▄▀░▀▄▀
#


#-------- Wit - Nintendo Wii/GameCube Roms Manager {{{
#------------------------------------------------------
# DEMO: https://www.youtube.com/watch?v=_vcdofAUcPI
# DESC: Convert Wii or Gamecube games to compatible formats to work on Softmodded/Modded Nintendo Wii Console
# REFF: https://gist.github.com/openback/1138763
#       Wii Backup Fusion GUI https://www.youtube.com/watch?v=8B2JOnFE5kM
#       https://sourceforge.net/projects/usbloadergx/
#       https://github.com/FIX94/Nintendont
#       https://sourceforge.net/projects/wiibafu/
#       http://wiki.gbatemp.net/wiki/Nintendont_Compatibility_List
#       https://github.com/FIX94/Nintendont
#       Format FAT32 32KB cluster https://gist.github.com/joshenders/4376942
# LINK: http://wit.wiimm.de/

convert-to-game-nintendont() {
  if [ $# -lt 1 ]; then
    echo -e "convert gamecube iso games to ciso (compress iso, ignore unused blocks)."
    echo -e "works with nintendont v4.428+ and usbloadergx on a modded wii console."
    echo -e "Note: after conversion the ciso will be renamed to iso to make it work under usbloadergx"
    echo -e "\nUsage: $0 <filename>"
    echo -e "\nExample:\n$0 Melee.iso"
    echo -e "$0 Melee.iso DoubleDash.iso WindWaker.iso"
    echo -e "$0 *.iso"
    echo -e "\nNintendont uses these paths:"
    echo -e "USB:/games/"
    echo -e "USB:/games/Name of game [GameID]/game.iso"
    echo -e "USB:/games/Legend of Zelda the Wind Waker (USA) [GZLP01]/game.iso"
    echo -e "\nMultiple Gamecube Disc Example:"
    echo -e "USB:/games/Resident Evil 4 (USA) [G4BE08]/game.iso"
    echo -e "USB:/games/Resident Evil 4 (USA) [G4BE08]/disc2.iso"
    return 1
  fi
  myArray=( "$@" )
  for arg in "${myArray[@]}"; do
    FILENAME="${arg%.*}"
    REGION=$(wit lll -H "$arg" | awk '{print $4}')
    GAMEID=$(wit lll -H "$arg" | awk '{print $1}')
    TITLE=$(wit lll -H "$arg" | awk '{ print substr($0, index($0,$5)) }' | awk '{$1=$1};1' )
    DIR_FILENAME="$FILENAME [$GAMEID]"
    DIR_TITLENAME="$TITLE ($REGION) [$GAMEID]"

    ## no conversion; only generate folder base on title inside the rom, move iso to folder
    # mkdir -pv "$DIR_TITLENAME"
    # mv -v "$arg" "$DIR_TITLENAME"/game.iso

    ## no conversion; only generate folder base on filename, move iso to folder
    # mkdir -pv "$DIR_FILENAME"
    # mv -v "$arg" "$DIR_FILENAME"/game.iso

    ## convert to ciso; generate folder base on title inside the rom; move ciso to folder
    ## rename ciso to iso ; this will make it compatible with both nintendont and usbloadergx
    # mkdir -pv "$DIR_TITLENAME"
    # wit copy --ciso "$arg" "$DIR_TITLENAME"/game.iso

    ## convert to ciso; generate folder base on filename; move ciso to folder
    ## rename ciso to iso ; this will make it compatible with both nintendont and usbloadergx
    mkdir -pv "$DIR_FILENAME"
    wit copy --ciso "$arg" "$DIR_FILENAME"/game.iso
  done
}

convert-to-game-usbloadergx() {
  if [ $# -lt 1 ]; then
    echo -e "convert wii iso games to wbfs that will works with usbloadergx on a modded wii console"
    echo -e "\nUsage: $0 <filename>"
    echo -e "\nExample:\n$0 WiiSports.iso"
    echo -e "$0 MarioKart.iso Zelda.iso DonkeyKong.iso"
    echo -e "$0 *.iso"
    echo -e "\nUSBLoaderGX uses these paths:"
    echo -e "USB:/wbfs/"
    echo -e "USB:/wbfs/Name of game [GameID]/GameID.wbfs"
    echo -e "USB:/wbfs/Donkey Kong Country Returns (USA) [SF8E01]/SF8E01.wbfs"
    echo -e "\nSplit Wii Game Example:"
    echo -e "USB:/wbfs/Super Smash Bros Brawl (NTSC) [RSBE01]/RSBE01.wbf1"
    echo -e "USB:/wbfs/Super Smash Bros Brawl (NTSC) [RSBE01]/RSBE01.wbf2"
    echo -e "USB:/wbfs/Super Smash Bros Brawl (NTSC) [RSBE01]/RSBE01.wbf3"
    echo -e "USB:/wbfs/Super Smash Bros Brawl (NTSC) [RSBE01]/RSBE01.wbfs"
    return 1
  fi
  myArray=( "$@" )
  for arg in "${myArray[@]}"; do
    FILENAME="${arg%.*}"
    REGION=$(wit lll -H "$arg" | awk '{print $4}')
    GAMEID=$(wit lll -H "$arg" | awk '{print $1}')
    TITLE=$(wit lll -H "$arg" | awk '{ print substr($0, index($0,$5)) }' | awk '{$1=$1};1' )
    DIR_FILENAME="$FILENAME [$GAMEID]"
    DIR_TITLENAME="$TITLE ($REGION) [$GAMEID]"

    ## create proper folder structure base on title inside the rom, scrub image & convert to wbfs, auto split at 4GB a piece
    # mkdir -pv "$DIR_TITLENAME"
    # wit copy --wbfs --split "$arg" "$DIR_TITLENAME"/"$GAMEID.wbfs"

    ## create proper folder structure base on filename, scrub image & convert to wbfs, auto split at 4GB a piece
    mkdir -pv "$DIR_FILENAME"
    wit copy --wbfs --split "$arg" "$DIR_FILENAME"/"$GAMEID.wbfs"
  done
}
# }}}
#
