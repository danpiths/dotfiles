{pkgs}: let
  nixTools = with pkgs; [
    graphite-cli
    chafa
    imagemagick
    ghostscript
    tectonic
    mermaid-cli
  ];
in
  nixTools
