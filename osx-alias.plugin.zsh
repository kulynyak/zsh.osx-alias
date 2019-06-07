#!/usr/bin/env zsh

if [[ "$OSTYPE" == darwin* ]]; then
  PREVIEW="Preview"
  # Desktop Programs
  alias chrome="open -a google\ chrome"
  # alias firefox="open -a firefox"
  alias firefox='open -a "firefox developer edition"'
  alias opera="open -a opera"
  alias safari="open -a safari"
  alias f='open -a Finder '
  alias fh='open -a Finder .'
  alias preview="open -a '$PREVIEW'"
  alias skype='open -a Skype'
  alias slack='open -a Slack'
  alias macpass='open -a MacPass'
  alias xcode="open -a '/Applications/XCode.app'"

  if [ -s /usr/bin/firefox ]; then
    unalias firefox
  fi

  # Get rid of those pesky .DS_Store files recursively
  alias dsclean='find . -type f -name .DS_Store -delete'

  # Track who is listening to your iTunes music
  alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'

  # Flush your dns cache
  alias flush='dscacheutil -flushcache'

  # Show/hide hidden files (for Mac OS X Mavericks)
  alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE"
  alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE"

  # From http://apple.stackexchange.com/questions/110343/copy-last-command-in-terminal
  alias copyLastCmd='fc -ln -1 | awk '\''{$1=$1}1'\'' ORS='\'''\'' | pbcopy'

  # Use Finder's Quick Look on a file (^C or space to close)
  alias ql='qlmanage -p 2>/dev/null'

  # Mute/Unmute the system volume. Plays nice with all other volume settings.
  alias mute="osascript -e 'set volume output muted true'"
  alias unmute="osascript -e 'set volume output muted false'"

  # fix user permissions
  alias reperm="chflags -R nouchg ~; diskutil resetUserPermissions / $(id -u)"

  # download a file and open it in Preview
  alias prevcurl='curl "$*" | open -fa $PREVIEW'

  function pman() {
    # about 'view man documentation in Preview'
    # param '1: man page to view'
    # example '$ pman bash'
    # group 'osx'
    man -t "${1}" | open -fa $PREVIEW
  }

  function refresh-launchpad() {
    # about 'Reset launchpad layout in macOS'
    # example '$ refresh-launchpad'
    # group 'osx'
    defaults write com.apple.dock ResetLaunchPad -bool TRUE
    killall Dock
  }

  function browser() {
    # about 'pipe html to a browser'
    # example '$ echo "<h1>hi mom!</h1>" | browser'
    # example '$ ron -5 man/rip.5.ron | browser'
    if [ -t 0 ]; then
      if [ -n "$1" ]; then
        open $1
      else
        echo "pipe html to a browser or specify file"
      fi
    else
      f="/tmp/browser.$RANDOM.html"
      cat /dev/stdin >$f
      open $f
    fi
  }
fi
