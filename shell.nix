{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = with pkgs; [
      ansible
      ansible-lint
      yamllint
    ];
}
