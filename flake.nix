{
  description = "Node.js packages in Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          nodejs_6 = pkgs.stdenv.mkDerivation {
            name = "node-6.17.1";
            src = pkgs.fetchurl {
              url = "https://nodejs.org/dist/v6.17.1/node-v6.17.1-darwin-x64.tar.gz";
              sha256 = "sha256-gDPgel2nWa8A23NkwjRPEe7/c7UWR9OZJr+jbyExuZA=";
            };
            installPhase = ''
              echo "install nodejs"
              mkdir -p $out
              cp -r ./ $out/
            '';
          };
        };
      });
}
