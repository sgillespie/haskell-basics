{
  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        overlays = [haskellNix.overlay];

        pkgs = import nixpkgs {
          inherit system overlays; inherit (haskellNix) config;
        };

        project = pkgs.haskell-nix.project' {
          src = ./.;
          compiler-nix-name = "ghc963";

          shell.tools = {
            cabal = {};
            fourmolu = {};
            hlint = {};
            haskell-language-server = {};
          };

          shell.buildInputs = with pkgs; [
            nixpkgs-fmt
          ];
        };

        flake = project.flake {};
    in pkgs.lib.recursiveUpdate flake {
      packages.default = flake.packages."haskell-basics:exe:haskell-basics";
    });
}
