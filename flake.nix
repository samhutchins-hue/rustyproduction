{
  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk { };
      in
      {
        # Build the default Rust package
        defaultPackage = naersk-lib.buildPackage ./.;

        # Define the development shell
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.rustc
            pkgs.cargo
            pkgs.openssl
            pkgs.pkg-config
            pkgs.gcc
            pkgs.cmake
            pkgs.rustPackages.clippy
            pkgs.rustfmt
            pkgs.pre-commit
          ];

          shellHook = ''
                        export OPENSSL_DIR=${pkgs.openssl.dev}
                        export OPENSSL_LIB_DIR=${pkgs.openssl.out}/lib
                        export PKG_CONFIG_PATH=${pkgs.openssl.dev}/lib/pkgconfig
echo "Rust development environment with OpenSSL is ready!"
          '';
        };
      }
    );
}
