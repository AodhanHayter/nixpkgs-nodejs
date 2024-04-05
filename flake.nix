{
  description = "Node.js packages in Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "aarch64-darwin" "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          nodejs_6 = pkgs.stdenv.mkDerivation {
            name = "nodejs6.17.1";
            src = pkgs.fetchurl {
              url = "https://nodejs.org/dist/v6.17.1/node-v6.17.1-darwin-x64.tar.gz";
              sha256 = "sha256-vTAqaJw8NOK2HYa5feZtJqM1iBoXrwm2oKS7EBnfVuQ=";
            };
            installPhase = ''
              echo "installing nodejs"
              mkdir -p $out
              cp -r ./ $out/
            '';
          };
        };
      };
    };
}
