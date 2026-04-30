{pkgs}: let
  forgecodeVersion = "2.12.10";
  forgecodeSha256 = "sha256-PDXkpVZeD2OU6R0ahmOQ0Ab5uNbGslwv1qwJi0aq5dQ";
  forgecode = pkgs.stdenvNoCC.mkDerivation {
    pname = "forgecode";
    version = forgecodeVersion;
    src = pkgs.fetchurl {
      url = "https://github.com/tailcallhq/forgecode/releases/download/v${forgecodeVersion}/forge-aarch64-apple-darwin";
      sha256 = forgecodeSha256;
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/forge
      chmod +x $out/bin/forge
    '';
  };

  nixTools = with pkgs; [
    utm
    graphite-cli
    chafa
    imagemagick
    ghostscript
    tectonic
    mermaid-cli
    devenv
    claude-code
    nodejs
    go
    erlang
    gleam
    forgecode
  ];
in
  nixTools
