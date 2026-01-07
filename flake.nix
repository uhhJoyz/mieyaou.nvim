{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    miaou.url = "github:uhhJoyz/miaou-wrapper";
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    miaou,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem = let
        meows = import ./meows.nix;
      in
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }: {
          packages = {
            default = miaou.lib.miaouCustom {
              inherit meows;
              inherit system;
            };
          };
        };
    };
}
