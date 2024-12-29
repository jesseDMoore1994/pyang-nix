{
  description = "A Flake that can build dry-python returns";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pyang-src = {
      url = "github:mbj4668/pyang";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, pyang-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in rec {
        packages.pyang = pkgs.python3Packages.buildPythonPackage {
          name = "pyang";
          src = pyang-src;
          propagatedBuildInputs = with pkgs.python3Packages; [ 
            setuptools
            lxml
          ];
        };
        defaultPackage = packages.pyang;
      }
    );
}
