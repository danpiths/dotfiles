{
  homeDirectory,
  pkgs,
}: let
  zshBat = pkgs.fetchFromGitHub {
    owner = "fdellwing";
    repo = "zsh-bat";
    rev = "master";
    sha256 = "sha256-TTuYZpev0xJPLgbhK5gWUeGut0h7Gi3b+e00SzFvSGo=";
  };
  zshViMode = pkgs.fetchFromGitHub {
    owner = "jeffreytse";
    repo = "zsh-vi-mode";
    rev = "master";
    sha256 = "sha256-WdZHCVxVVOs4HyG5f56vAA17UWYOvb9Yf6v7M1RIdU4=";
  };
in {
  enable = true;
  autocd = true;
  enableCompletion = true;

  history.ignoreAllDups = true;

  historySubstringSearch.enable = true;

  syntaxHighlighting.enable = true;

  autosuggestion.enable = true;

  initContent = ''
    export FORGE_CONFIG="${homeDirectory}/.config/forgecode"
    export HISTORY_IGNORE=":*"

    if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        export APPEARANCE="dark"
    else
        export APPEARANCE="light"
    fi

    # forge shell integration
    if [[ -z "$_FORGE_PLUGIN_LOADED" ]]; then
        eval "$(forge zsh plugin)"
    fi
    if [[ -z "$_FORGE_THEME_LOADED" ]]; then
        eval "$(forge zsh theme)"
    fi

    # re-apply forge keybindings after zsh-vi-mode overrides them
    function zvm_after_init() {
        bindkey '^M' forge-accept-line
        bindkey '^J' forge-accept-line
        bindkey '^I' forge-completion
    }
  '';

  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
      "web-search"
    ];
  };

  plugins = [
    {
      name = "zsh-bat";
      src = zshBat;
      file = "zsh-bat.plugin.zsh";
    }
    {
      name = "zsh-vi-mode";
      src = zshViMode;
      file = "zsh-vi-mode.plugin.zsh";
    }
  ];

  shellAliases = {
    dlp = "function _dlp() { yt-dlp \"$1\" -o \"${homeDirectory}/Downloads/yt-dlp/$2/$2.mp4\" --embed-thumbnail --embed-metadata --sub-format srt --convert-subs srt --write-sub --write-auto-sub --sub-lang \"en.*\" -f \"bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best\" $3; }; _dlp";
    rmf = "rm -rf";
    zsrc = "source ~/.zshrc";

    # git
    gtst = "git stash -u";
    gtsp = "git stash pop";
    gtsl = "git stash list";
    gtsd = "git stash drop";
    gtsa = "git stash apply";
    gtsdi = "function _gtsdi() { git stash drop stash@{$1}; }; _gtsdi";
    gtspi = "function _gtspi() { git stash apply stash@{$1}; }; _gtspi";
    lg = "lazygit";

    # eza
    ls = "eza --icons";
    lsa = "eza --all --icons";
    ll = "eza --long --header --git --icons";
    lla = "eza --long --header --git --all --icons";
    ltree = "eza --tree --ignore-glob=\"node_modules\" --icons";
    latree = "eza --tree --ignore-glob=\"node_modules\" --all --icons";

    # custom
    cpntfs = "sudo rsync -azP --no-o --no-g";
    mntfs = "sudo ${../../files/scripts/mount-ntfs.sh}";
    untfs = "sudo ${../../files/scripts/unmount-ntfs.sh}";
  };
}
