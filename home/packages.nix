{
  pkgs,
  inputs,
}: let
  forgecode = pkgs.stdenvNoCC.mkDerivation {
    pname = "forgecode";
    version = "bin";
    src = inputs.forgecode-bin;
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
    beamPackages.erlang
    gleam
    bruno
    gum
    forgecode
  ];
in
  nixTools
