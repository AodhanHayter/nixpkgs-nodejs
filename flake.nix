{
  description = "Node.js packages in Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "x86_64-linux" ];
      perSystem = { config, pkgs, system, ... }: {
        packages = {
          nodejs_6 = pkgs.stdenv.mkDerivation {
            name = "node";
            src = pkgs.fetchurl {
              url = "https://nodejs.org/dist/v6.17.1/node-v6.17.1-darwin-x64.tar.gz";
              sha256 = "sha256-gDPgel2nWa8A23NkwjRPEe7/c7UWR9OZJr+jbyExuZA=";
            };
            installPhase = ''
              echo "installing nodejs"
              mkdir -p $out
              cp -r ./ $out/
            '';
          };
        };
      };
      flake = {};
    };
}
