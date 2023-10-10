{ pkgs, ... }:

{
  packages = with pkgs; [ typst typst-lsp ];
}
