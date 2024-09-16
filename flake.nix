{
  description = "Fuzzy finder for `nix profile remove`";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs: let 
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.nprm = pkgs.writeShellScriptBin "nprm" ''
      nix profile list --json \
      | ${pkgs.jq}/bin/jq -r '.elements | to_entries[] | "\(.key) \(.value.storePaths[0])"' \
      | ${pkgs.fzf}/bin/fzf --with-nth 2 \
      | ${pkgs.gawk}/bin/awk '{print $1}' \
      | ${pkgs.findutils}/bin/xargs nix profile remove
    '';
    packages.x86_64-linux.default = inputs.self.outputs.packages.x86_64-linux.nprm;
  };
}
