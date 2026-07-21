{
  homeDirectory,
  pkgs,
  config,
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
  gumColors = config.lib.stylix.colors.withHashtag;
  sudoPreserveEnv = builtins.concatStringsSep "," [
    "COLOR_BASE"
    "COLOR_SURFACE"
    "COLOR_OVERLAY"
    "COLOR_MUTED"
    "COLOR_SUBTLE"
    "COLOR_TEXT"
    "COLOR_ACCENT"
    "COLOR_INFO"
    "COLOR_SUCCESS"
    "COLOR_WARNING"
    "COLOR_ERROR"
    "FOREGROUND"
    "BORDER_FOREGROUND"
    "GUM_INPUT_PROMPT_FOREGROUND"
    "GUM_INPUT_PLACEHOLDER_FOREGROUND"
    "GUM_INPUT_CURSOR_FOREGROUND"
    "GUM_INPUT_HEADER_FOREGROUND"
  ];
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
    export PATH="${homeDirectory}/go/bin:$PATH"

    # gum styling from Stylix's active Base16 theme
    export COLOR_BASE="${gumColors.base00}"
    export COLOR_SURFACE="${gumColors.base01}"
    export COLOR_OVERLAY="${gumColors.base02}"
    export COLOR_MUTED="${gumColors.base03}"
    export COLOR_SUBTLE="${gumColors.base04}"
    export COLOR_TEXT="${gumColors.base05}"
    export COLOR_ACCENT="${gumColors.base0E}"
    export COLOR_INFO="${gumColors.base0D}"
    export COLOR_SUCCESS="${gumColors.base0B}"
    export COLOR_WARNING="${gumColors.base0A}"
    export COLOR_ERROR="${gumColors.base08}"

    export GUM_FILTER_INDICATOR_FOREGROUND="$COLOR_ACCENT"
    export GUM_FILTER_SELECTED_PREFIX_FOREGROUND="$COLOR_ACCENT"
    export GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND="$COLOR_MUTED"
    export GUM_FILTER_HEADER_FOREGROUND="$COLOR_ACCENT"
    export GUM_FILTER_TEXT_FOREGROUND="$COLOR_TEXT"
    export GUM_FILTER_MATCH_FOREGROUND="$COLOR_ACCENT"
    export GUM_FILTER_PROMPT_FOREGROUND="$COLOR_MUTED"
    export GUM_FILTER_PLACEHOLDER_FOREGROUND="$COLOR_MUTED"

    export GUM_INPUT_PROMPT_FOREGROUND="$COLOR_MUTED"
    export GUM_INPUT_PLACEHOLDER_FOREGROUND="$COLOR_MUTED"
    export GUM_INPUT_CURSOR_FOREGROUND="$COLOR_ACCENT"
    export GUM_INPUT_HEADER_FOREGROUND="$COLOR_ACCENT"

    export FOREGROUND="$COLOR_TEXT"
    export BORDER_FOREGROUND="$COLOR_ACCENT"

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

    # Keep Forge output visible when zle reset-prompt redraws a multi-line prompt.
    function _forge_reset() {
        BUFFER=""
        CURSOR=0
        zle -I
        printf '\n\n'
        zle reset-prompt
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
    ls = "eza --icons=always";
    lsa = "eza --all --icons=always";
    ll = "eza --long --header --git --icons=always";
    lla = "eza --long --header --git --all --icons=always";
    ltree = "eza --tree --ignore-glob=\"node_modules\" --icons=always";
    latree = "eza --tree --ignore-glob=\"node_modules\" --all --icons=always";

    # custom
    cpntfs = "sudo rsync -azP --no-o --no-g";
    mntfs = "sudo --preserve-env=${sudoPreserveEnv} ${../../files/scripts/mount-ntfs.sh}";
    untfs = "sudo --preserve-env=${sudoPreserveEnv} ${../../files/scripts/unmount-ntfs.sh}";
    gtr = "${../../files/scripts/git-rename-convention.sh}";
  };
}
