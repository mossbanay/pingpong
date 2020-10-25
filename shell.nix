{ pkgs ? import <nixos> { } }:

with pkgs;

mkShell {
  name = "rustEnv";

  buildInputs = [
    terraform
    awscli
    ansible
    python37Packages.j2cli
    python37Packages.setuptools
  ];

  shellHooks = "";
}
