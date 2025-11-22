{pkgs}: let
  nixTools = with pkgs; [
    graphite-cli
    chafa
    imagemagick
  ];
in
  nixTools
